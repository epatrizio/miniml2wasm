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

type var_access =
  | Get
  | Set

exception Compiling_error of string

let error loc message =
  let message = Format.sprintf {|%s: %s|} (str_loc loc) message in
  raise (Compiling_error message)

let get_local_idx loc name env =
  match Env.get_local_wasm_idx name env with
  | Some idx -> idx
  | None -> error loc "local not exists!"

let get_var_idx buf var_access loc name env =
  let local_action buf = function
    | Get -> Buffer.add_char buf '\x20'
    | Set -> Buffer.add_char buf '\x21'
  in
  let global_action buf = function
    | Get -> Buffer.add_char buf '\x23'
    | Set -> Buffer.add_char buf '\x24'
  in
  match Env.get_local_wasm_idx name env with
  | Some idx ->
    local_action buf var_access;
    idx
  | None -> (
    match Env.get_global_wasm_idx name env with
    | Some idx ->
      global_action buf var_access;
      idx
    | None -> error loc "var not exists!" )

let get_blocktype = function
  | Tunit -> Empty
  | Tbool -> Valtyp Tbool
  | Ti32 -> Valtyp Ti32
  | Tarray _ -> assert false
  | Tref _ -> assert false
  | Tunknown -> assert false

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

let write_unreachable buf = Buffer.add_char buf '\x00'

let write_nop buf = Buffer.add_char buf '\x01'

let write_br buf idx =
  Buffer.add_char buf '\x0c';
  write_u32_of_int buf idx

let write_br_if buf idx =
  Buffer.add_char buf '\x0d';
  write_u32_of_int buf idx

let write_return buf = Buffer.add_char buf '\x0f'

let write_numtype buf = function
  | Tbool | Ti32 | Tref Ti32 | Tref Tbool -> Buffer.add_char buf '\x7f'
  | Tunit | Tref _ | Tunknown -> ()
  | Tarray _ -> assert false

let write_valtype = write_numtype

let write_mut buf = function
  | Tunit | Tbool | Ti32 -> Buffer.add_char buf '\x00'
  | Tref _ -> Buffer.add_char buf '\x01'
  | Tarray _ -> assert false
  | Tunknown -> assert false

let write_blocktype buf = function
  | Empty -> Buffer.add_char buf '\x40'
  | Valtyp typ -> write_valtype buf typ
  | S33 _ -> assert false

let write_globaltype buf typ =
  write_valtype buf typ;
  write_mut buf typ

let rec compile_expr (loc, typ, expr') stack_nb_elts env =
  let buf = Buffer.create 16 in
  match expr' with
  | Ecst Cunit -> Ok (buf, stack_nb_elts, env)
  | Ecst (Cbool b) ->
    Buffer.add_char buf '\x41';
    write_u32_of_int buf (if b then 1 else 0);
    Ok (buf, stack_nb_elts + 1, env)
  | Ecst (Ci32 i32) ->
    Buffer.add_char buf '\x41';
    write_s32 buf i32;
    Ok (buf, stack_nb_elts + 1, env)
  | Eident (_typ, name) ->
    let idx = get_var_idx buf Get loc name env in
    write_u32_of_int buf idx;
    Ok (buf, stack_nb_elts + 1, env)
  | Eunop (Unot, expr) ->
    let* expr_buf, stack_nb_elts, env = compile_expr expr stack_nb_elts env in
    Buffer.add_buffer buf expr_buf;
    Buffer.add_char buf '\x45';
    (* i32.eqz *)
    Ok (buf, stack_nb_elts, env)
  | Eunop (Uminus, expr) ->
    compile_expr
      (loc, typ, Ebinop ((loc, Ti32, Ecst (Ci32 Int32.minus_one)), Bmul, expr))
      stack_nb_elts env
  | Ebinop (e1, binop, e2) -> compile_binop buf stack_nb_elts e1 binop e2 env
  | Eblock block ->
    let* block_buf, typ, stack_nb_elts, env =
      compile_block block stack_nb_elts env
    in
    let blocktype = get_blocktype typ in
    Buffer.add_char buf '\x02';
    write_blocktype buf blocktype;
    Buffer.add_buffer buf block_buf;
    Buffer.add_char buf '\x0b';
    Ok (buf, stack_nb_elts, env)
  | Eif (e_cond, e_then, e_else) ->
    let _loc, typ, _expr' = e_then in
    let* e_cond_buf, stack_nb_elts, env =
      compile_expr e_cond stack_nb_elts env
    in
    let* e_then_buf, stack_nb_elts, env =
      compile_expr e_then stack_nb_elts env
    in
    let* e_else_buf, _stack_nb_elts, env =
      compile_expr e_else stack_nb_elts env
    in
    let blocktype = get_blocktype typ in
    (* _stack_nb_elts: same stack state on both branches *)
    Buffer.add_buffer buf e_cond_buf;
    Buffer.add_char buf '\x04';
    write_blocktype buf blocktype;
    Buffer.add_buffer buf e_then_buf;
    Buffer.add_char buf '\x05';
    Buffer.add_buffer buf e_else_buf;
    Buffer.add_char buf '\x0b';
    Ok (buf, stack_nb_elts - 1, env)
  | Elet ((typ, name), e1, e2) ->
    let env = Env.add_local_wasm name typ env in
    let idx = get_local_idx loc name env in
    let* e1_buf, stack_nb_elts, env = compile_expr e1 stack_nb_elts env in
    let* e2_buf, stack_nb_elts, env = compile_expr e2 stack_nb_elts env in
    Buffer.add_buffer buf e1_buf;
    Buffer.add_char buf '\x21';
    (* local.set *)
    write_u32_of_int buf idx;
    Buffer.add_buffer buf e2_buf;
    Ok (buf, stack_nb_elts - 1, env)
  | Eref expr ->
    let* expr_buf, stack_nb_elts, env = compile_expr expr stack_nb_elts env in
    Ok (expr_buf, stack_nb_elts, env)
  | Ederef (typ, name) ->
    compile_expr (loc, typ, Eident (typ, name)) stack_nb_elts env
  | Earray_init _el -> assert false
  | Earray (_ident, _expr) -> assert false
  | Estmt (_loc, Slet ((typ, name), expr)) ->
    let global_buf = Buffer.create 16 in
    let* expr_buf, _stack_nb_elts, env = compile_expr expr stack_nb_elts env in
    Buffer.add_char expr_buf '\x0b';
    write_globaltype global_buf typ;
    Buffer.add_buffer global_buf expr_buf;
    let env = Env.add_global_wasm name global_buf env in
    Ok (buf, stack_nb_elts, env)
  | Estmt (loc, Srefassign ((_typ, name), expr)) ->
    let* expr_buf, stack_nb_elts, env = compile_expr expr stack_nb_elts env in
    Buffer.add_buffer buf expr_buf;
    let idx = get_var_idx buf Set loc name env in
    write_u32_of_int buf idx;
    Ok (buf, stack_nb_elts - 1, env)
  | Estmt (_loc, Sarrayassign ((_typ, _name), _e1, _e2)) -> assert false
  | Estmt (_loc, Swhile (cond_expr, block)) ->
    let* cond_expr_buf, stack_nb_elts, env =
      compile_expr cond_expr stack_nb_elts env
    in
    let* block_buf, typ, stack_nb_elts, env =
      compile_block block stack_nb_elts env
    in
    let blocktype = get_blocktype typ in
    Buffer.add_char buf '\x03';
    write_blocktype buf blocktype;
    Buffer.add_buffer buf cond_expr_buf;
    (* while condition is checked by a if expr *)
    Buffer.add_char buf '\x04';
    write_blocktype buf Empty;
    Buffer.add_buffer buf block_buf;
    write_br buf 1;
    Buffer.add_char buf '\x05';
    write_nop buf;
    (* if end *)
    Buffer.add_char buf '\x0b';
    (* loop end *)
    Buffer.add_char buf '\x0b';
    Ok (buf, stack_nb_elts - 1, env)
  | Estmt (_loc, Sarray_size (_typ, _name)) -> assert false
  | _ -> error loc "expression to be implemented!"

and compile_block block stack_nb_elts env =
  match block with
  | Bexpr (loc, typ, expr') ->
    let* buf, stack_nb_elts, env =
      compile_expr (loc, typ, expr') stack_nb_elts env
    in
    Ok (buf, typ, stack_nb_elts, env)
  | Bseq ((loc, typ, expr'), block) ->
    let* buf, stack_nb_elts, env =
      compile_expr (loc, typ, expr') stack_nb_elts env
    in
    let* block_buf, typ, stack_nb_elts, env =
      compile_block block stack_nb_elts env
    in
    Buffer.add_buffer buf block_buf;
    Ok (buf, typ, stack_nb_elts, env)

and compile_binop buf stack_nb_elts e1 binop e2 env =
  let* e1_buf, stack_nb_elts, env = compile_expr e1 stack_nb_elts env in
  let* e2_buf, stack_nb_elts, env = compile_expr e2 stack_nb_elts env in
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
  Ok (buf, stack_nb_elts - 1, env)

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

let encode_prog prog env =
  let rec drop buf n =
    if n = 0 then ()
    else (
      Buffer.add_char buf '\x1a';
      drop buf (n - 1) )
  in
  let get_locals env =
    let locals = Env.get_locals_wasm_typs env in
    List.map
      (fun typ ->
        let buf = Buffer.create 16 in
        write_u32_of_int buf 1;
        write_valtype buf typ;
        buf )
      locals
  in
  let rec compile_prog buf prog stack_nb_elts env =
    begin
      match prog with
      | Bexpr expr ->
        let* expr_buf, stack_nb_elts, env =
          compile_expr expr stack_nb_elts env
        in
        Buffer.add_buffer buf expr_buf;
        Ok (buf, stack_nb_elts, env)
      | Bseq (expr, block) ->
        let* expr_buf, stack_nb_elts, env =
          compile_expr expr stack_nb_elts env
        in
        Buffer.add_buffer buf expr_buf;
        compile_prog buf block stack_nb_elts env
    end
  in
  let buf = Buffer.create 256 in
  let locals_buf = Buffer.create 256 in
  let code_buf = Buffer.create 256 in
  let* code_buf, stack_nb_elts, env = compile_prog code_buf prog 0 env in
  drop code_buf stack_nb_elts;
  Buffer.add_char code_buf '\x0b';
  let locals_buf_list = get_locals env in
  write_vector locals_buf locals_buf_list;
  let code_len = Buffer.length code_buf in
  let code_len = code_len + Buffer.length locals_buf in
  write_u32_of_int buf code_len;
  Buffer.add_buffer buf locals_buf;
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

let write_global_section buf env =
  if Env.is_empty_globals_wasm env then ()
  else
    let global_buf = Buffer.create 32 in
    let globals = Env.get_globals_wasm_datas env in
    write_vector global_buf globals;
    write_section buf '\x06' global_buf

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
  let* code_buf, env = encode_prog prog env in
  write_type_section buf [ functype_buf ];
  (* hard-coded: start function idx = 0 *)
  write_function_section buf [ 0 ];
  write_global_section buf env;
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
