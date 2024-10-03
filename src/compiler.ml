(* WebAssembly (Wasm) compiler *)

(* source of some basic encoding functions :
   https://github.com/OCamlPro/owi/blob/main/src/ast/binary_encoder.ml
   owi (developed by my friends at OCamlPro): A WebAssembly Swissknife & cross-language bugfinder *)

open Ast
open Syntax

type blocktype =
  | Empty
  | Valtyp of typ
  | S33 of int64

exception Compiling_error of string

let error loc message =
  let message = Format.sprintf {|%s: %s|} (str_loc loc) message in
  raise (Compiling_error message)

let stack_nb_elts = ref 0

(* add byte from int (ascii code) *)
let write_byte buf i =
  let c = Char.chr (i land 0xff) in
  Buffer.add_char buf c

let rec write_u64 buf i =
  let b = Int64.to_int (Int64.logand i 0x7fL) in
  if Int64.compare 0L i <= 0 && Int64.compare i 128L < 0 then write_byte buf b
  else begin
    write_byte buf (b lor 0x80);
    write_u64 buf (Int64.shift_right_logical i 7)
  end

let write_u32 buf i =
  write_u64 buf (Int64.logand (Int64.of_int32 i) 0xffffffffL)

let write_u32_of_int buf i =
  let i = Int32.of_int i in
  write_u32 buf i

let rec write_s64 buf i =
  let b = Int64.to_int (Int64.logand i 0x7fL) in
  if Int64.compare (-64L) i <= 0 && Int64.compare i 64L < 0 then
    write_byte buf b
  else begin
    write_byte buf (b lor 0x80);
    write_s64 buf (Int64.shift_right i 7)
  end

let write_s32 buf i = write_s64 buf (Int64.of_int32 i)

let write_s32_of_int buf i =
  let i = Int32.of_int i in
  write_s32 buf i

let write_vector buf datas =
  let vector_buf = Buffer.create 16 in
  let len = List.length datas in
  List.iter (Buffer.add_buffer vector_buf) datas;
  write_u32_of_int buf len;
  Buffer.add_buffer buf vector_buf

let write_section buf id content =
  let section_len = Buffer.length content in
  if section_len > 0 then begin
    Buffer.add_char buf id;
    write_u32_of_int buf section_len;
    Buffer.add_buffer buf content
  end

let write_numtype buf = function
  | Tbool | Ti32 -> Buffer.add_char buf '\x7f'
  | Tunit | Tunknown -> ()

let write_valtype = write_numtype

let write_blocktype buf = function
  | Empty | S33 _ -> ()
  | Valtyp typ -> write_valtype buf typ

let rec compile_expr (loc, typ, expr') env =
  let buf = Buffer.create 16 in
  match expr' with
  | Ecst Cunit -> Ok (buf, env)
  | Ecst (Cbool b) ->
    incr stack_nb_elts;
    Buffer.add_char buf '\x41';
    write_u32_of_int buf (if b then 1 else 0);
    Ok (buf, env)
  | Ecst (Ci32 i32) ->
    incr stack_nb_elts;
    Buffer.add_char buf '\x41';
    write_s32 buf i32;
    Ok (buf, env)
  | Eunop (Unot, expr) ->
    let* expr_buf, env = compile_expr expr env in
    Buffer.add_buffer buf expr_buf;
    Buffer.add_char buf '\x45';
    (* i32.eqz *)
    Ok (buf, env)
  | Eunop (Uminus, expr) ->
    compile_expr
      (loc, typ, Ebinop ((loc, Ti32, Ecst (Ci32 Int32.minus_one)), Bmul, expr))
      env
  | Ebinop (e1, binop, e2) -> compile_binop buf e1 binop e2 env
  | Eblock block -> begin
    match block with
    | Bexpr expr -> compile_expr expr env
    | Bseq (expr, block) ->
      let* expr_buf, env = compile_expr expr env in
      let* block_buf, env = compile_expr (loc, typ, Eblock block) env in
      Buffer.add_buffer buf expr_buf;
      Buffer.add_buffer buf block_buf;
      Ok (buf, env)
  end
  | Eif (e_cond, e_then, e_else) ->
    let _loc, typ, _expr' = e_then in
    let* e_cond_buf, env = compile_expr e_cond env in
    let* e_then_buf, env = compile_expr e_then env in
    let* e_else_buf, env = compile_expr e_else env in
    Buffer.add_buffer buf e_cond_buf;
    Buffer.add_char buf '\x04';
    write_blocktype buf (Valtyp typ);
    Buffer.add_buffer buf e_then_buf;
    Buffer.add_char buf '\x05';
    Buffer.add_buffer buf e_else_buf;
    Buffer.add_char buf '\x0b';
    decr stack_nb_elts;
    Ok (buf, env)
  | _ -> error loc "expression to be implemented!"

and compile_binop buf e1 binop e2 env =
  let* e1_buf, env = compile_expr e1 env in
  let* e2_buf, env = compile_expr e2 env in
  Buffer.add_buffer buf e1_buf;
  Buffer.add_buffer buf e2_buf;
  (* i32.and ... *)
  (* Int32: signed intergers > _s operators *)
  (* div_s, lt_s, gt_s ... *)
  begin
    match binop with
    | Band -> Buffer.add_char buf '\x71'
    | Bor -> Buffer.add_char buf '\x72'
    | Badd -> Buffer.add_char buf '\x6a'
    | Bsub -> Buffer.add_char buf '\x6b'
    | Bmul -> Buffer.add_char buf '\x6c'
    | Bdiv -> Buffer.add_char buf '\x6d'
    | Beq -> Buffer.add_char buf '\x46'
    | Bneq -> Buffer.add_char buf '\x47'
    | Blt -> Buffer.add_char buf '\x48'
    | Ble -> Buffer.add_char buf '\x4c'
    | Bgt -> Buffer.add_char buf '\x4a'
    | Bge -> Buffer.add_char buf '\x4e'
  end;
  decr stack_nb_elts;
  Ok (buf, env)

let encode_functype arg_resulttypes ret_resulttypes =
  let buf = Buffer.create 16 in
  Buffer.add_char buf '\x60';
  write_vector buf arg_resulttypes;
  write_vector buf ret_resulttypes;
  buf

let encode_empty_code () =
  let buf = Buffer.create 16 in
  write_u32_of_int buf 2;
  (* locals *)
  write_vector buf [];
  (* explicit end opcode *)
  Buffer.add_char buf '\x0b';
  buf

let rec encode_prog buf prog env =
  let* code_buf, env =
    begin
      match prog with
      | Bexpr expr -> compile_expr expr env
      | Bseq (expr, block) ->
        let* code_buf, env = compile_expr expr env in
        encode_prog code_buf block env
    end
  in
  while !stack_nb_elts > 0 do
    (* drop: the stack must be empty at the end *)
    Buffer.add_char code_buf '\x1a';
    decr stack_nb_elts
  done;
  Buffer.add_char code_buf '\x0b';
  let code_len = Buffer.length code_buf in
  (* code_len + 1: empty locals *)
  let code_len = code_len + 1 in
  write_u32_of_int buf code_len;
  write_vector buf [];
  Buffer.add_buffer buf code_buf;
  Ok (buf, env)

let write_type_section buf functypes =
  let type_buf = Buffer.create 16 in
  write_vector type_buf functypes;
  write_section buf '\x01' type_buf

let write_function_section buf typeidxs =
  let function_buf = Buffer.create 16 in
  let typeidxs =
    List.fold_left
      (fun typeidx_l idx ->
        let typeidx_buf = Buffer.create 2 in
        write_u32_of_int typeidx_buf idx;
        typeidx_l @ [ typeidx_buf ] )
      [] typeidxs
  in
  write_vector function_buf typeidxs;
  write_section buf '\x03' function_buf

let write_code_section buf codes =
  let code_buf = Buffer.create 16 in
  write_vector code_buf codes;
  write_section buf '\x0a' code_buf

let write_start_section buf =
  let start_buf = Buffer.create 2 in
  (* hard-coded: start function idx = 0 *)
  write_u32_of_int start_buf 0;
  write_section buf '\x08' start_buf

let write_start_function buf prog env =
  let functype_buf = encode_functype [] [] in
  let code_buf = Buffer.create 256 in
  let* code_buf, _env = encode_prog code_buf prog env in
  write_type_section buf [ functype_buf ];
  (* hard-coded: start function idx = 0 *)
  write_function_section buf [ 0 ];
  write_start_section buf;
  write_code_section buf [ code_buf ];
  Ok (buf, env)

let compile prog env =
  let wasm_buf = Buffer.create 256 in
  (* magic *)
  Buffer.add_string wasm_buf "\x00\x61\x73\x6d";
  (* version *)
  Buffer.add_string wasm_buf "\x01\x00\x00\x00";
  (* First basic approach: prog is fully compile in start function *)
  let* wasm_buf, env = write_start_function wasm_buf prog env in
  let wasm_str = Buffer.contents wasm_buf in
  Ok (wasm_str, env)
