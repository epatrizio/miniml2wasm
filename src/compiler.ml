(* WebAssembly (Wasm) compiler *)

open Ast
open Compiler_basic
open Syntax

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

(* Array representation: details in Memory module *)
let rec compile_array_init buf pt typ el stack_nb_elts env =
  match typ with
  | Tarray (typ, size) when typ = Ti32 || typ = Tbool ->
    (* 1. type id: i32 = 0 - bool = 1 *)
    write_i32_const_u buf pt;
    write_i32_const_u buf (if typ = Ti32 then 0l else 1l);
    write_store buf typ;
    (* 2. array_size: i32 value *)
    write_i32_const_u buf (Int32.add pt 4l);
    write_i32_const_u buf size;
    write_store buf Ti32;
    (* 3. array content *)
    let _pt, _stack_nb_elts, env =
      List.fold_left
        (fun (pt, stack_nb_elts, env) expr ->
          write_i32_const_u buf pt;
          let ret = compile_expr expr stack_nb_elts env in
          match ret with
          | Ok (expr_buf, stack_nb_elts, env) ->
            Buffer.add_buffer buf expr_buf;
            write_store buf typ;
            (Int32.add pt 4l, stack_nb_elts, env)
          | Error _ -> assert false )
        (Int32.add pt 8l, stack_nb_elts, env)
        el
    in
    env
  | _ -> assert false

and compile_array_pointer buf loc name idx_expr stack_nb_elts env =
  (* 1. get array memory pointer *)
  let idx = get_var_idx buf Get loc name env in
  write_u32_of_int buf idx;
  (* 2. pointer beyond meta data (typ and size = 8) *)
  write_i32_const_u buf 8l;
  write_binop buf Badd;
  (* 3.1 compile expr: col idx *)
  let* expr_buf, stack_nb_elts, env = compile_expr idx_expr stack_nb_elts env in
  Buffer.add_buffer buf expr_buf;
  (* 3.2 idx * typ_size : hard coded 4 (TODO) *)
  write_i32_const_u buf 4l;
  write_binop buf Bmul;
  (* 3.3 move pointer *)
  write_binop buf Badd;
  Ok (stack_nb_elts, env)

and compile_expr (loc, typ, expr') stack_nb_elts env =
  let buf = Buffer.create 16 in
  match expr' with
  | Ecst Cunit -> Ok (buf, stack_nb_elts, env)
  | Ecst (Cbool b) ->
    write_i32_const_u buf (if b then 1l else 0l);
    Ok (buf, stack_nb_elts + 1, env)
  | Ecst (Ci32 i32) ->
    write_i32_const_s buf i32;
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
  | Earray_init el ->
    let env = Env.malloc_array typ env in
    let env =
      compile_array_init buf env.memory.previous_pointer typ el stack_nb_elts
        env
    in
    write_i32_const_u buf env.memory.previous_pointer;
    Ok (buf, stack_nb_elts + 1, env)
  | Earray ((typ, name), expr) ->
    let* stack_nb_elts, env =
      compile_array_pointer buf loc name expr stack_nb_elts env
    in
    write_load buf typ;
    Ok (buf, stack_nb_elts, env)
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
  | Estmt (loc, Sarrayassign ((typ, name), e1, e2)) ->
    let* stack_nb_elts, env =
      compile_array_pointer buf loc name e1 stack_nb_elts env
    in
    let* e2_buf, stack_nb_elts, env = compile_expr e2 stack_nb_elts env in
    Buffer.add_buffer buf e2_buf;
    write_store buf typ;
    Ok (buf, stack_nb_elts - 2, env)
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
  | Estmt (_loc, Sarray_size (_typ, name)) ->
    (* 1. get array memory pointer *)
    let idx = get_var_idx buf Get loc name env in
    write_u32_of_int buf idx;
    (* 2. size = 2nd meta data *)
    write_i32_const_u buf 4l;
    write_binop buf Badd;
    write_load buf Ti32;
    Ok (buf, stack_nb_elts + 1, env)
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
  write_binop buf binop;
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

let write_memory_section buf env =
  if Env.is_empty_memory env then ()
  else begin
    let memories_buf = Buffer.create 32 in
    let memory_buf = Buffer.create 16 in
    (* single linear memory: default = 1 page *)
    write_memtype memory_buf (Limit_without_max 1l);
    write_vector memories_buf [ memory_buf ];
    write_section buf '\x05' memories_buf
  end

let write_global_section buf env =
  if Env.is_empty_globals_wasm env then ()
  else begin
    let global_buf = Buffer.create 32 in
    let globals = Env.get_globals_wasm_datas env in
    write_vector global_buf globals;
    write_section buf '\x06' global_buf
  end

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
  write_memory_section buf env;
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
