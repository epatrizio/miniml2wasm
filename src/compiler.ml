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
  | Tarray (typ, size) ->
    (* 1. type i32 id: check get_type_id_for_array for supported types *)
    let typ_i32 = get_type_id_for_array typ in
    write_i32_const_u buf pt;
    write_i32_const_u buf typ_i32;
    write_store buf typ;
    (* 2. array_size: i32 value *)
    write_i32_const_u buf (Int32.add pt 4l);
    write_i32_const_u buf size;
    write_store buf Ti32;
    (* 3. array content *)
    let _pt, stack_nb_elts, env =
      List.fold_left
        (fun (pt, stack_nb_elts, (env : _ Env.t)) expr ->
          let ret = compile_expr expr stack_nb_elts env in
          match ret with
          | Ok (expr_buf, stack_nb_elts, env) -> begin
            match typ with
            | Ti32 | Tbool ->
              write_i32_const_u buf pt;
              Buffer.add_buffer buf expr_buf;
              write_store buf typ;
              (Int32.add pt 4l, stack_nb_elts - 1, env)
            | Tarray (Ti32, _) | Tarray (Tbool, _) ->
              write_i32_const_u buf pt;
              write_i32_const_u buf env.memory.previous_pointer;
              write_store buf typ;
              Buffer.add_buffer buf expr_buf;
              (Int32.add pt 4l, stack_nb_elts, env)
            | _ -> assert false
          end
          | Error _ -> assert false )
        (Int32.add pt 8l, stack_nb_elts, env)
        el
    in
    (stack_nb_elts, env)
  | _ -> assert false

and compile_array_pointer buf loc name idx_expr stack_nb_elts env =
  (* 1. get array memory pointer *)
  let idx = get_var_idx buf Get loc name env in
  write_u32_of_int buf idx;
  (* 2. *)
  compile_array_pointer_from_pt buf idx_expr stack_nb_elts env

and compile_array_pointer_from_pt buf idx_expr stack_nb_elts env =
  (* 1. pointer beyond meta data (typ and size = 8) *)
  write_i32_const_u buf 8l;
  write_binop buf Badd;
  (* 2.1 compile expr: col idx *)
  let* expr_buf, stack_nb_elts, env = compile_expr idx_expr stack_nb_elts env in
  Buffer.add_buffer buf expr_buf;
  (* 2.2 idx * typ_size : hard coded 4 (TODO) *)
  write_i32_const_u buf 4l;
  write_binop buf Bmul;
  (* 2.3 move pointer *)
  write_binop buf Badd;
  Ok (stack_nb_elts, env)

and compile_var buf loc var stack_nb_elts env =
  match var with
  | Vident (_typ, name) ->
    let idx = get_var_idx buf Get loc name env in
    write_u32_of_int buf idx;
    Ok (buf, stack_nb_elts + 1, env)
  | Varray ((typ, name), expr) ->
    let* stack_nb_elts, env =
      compile_array_pointer buf loc name expr stack_nb_elts env
    in
    write_load buf typ;
    Ok (buf, stack_nb_elts, env)

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
  | Evar var -> compile_var buf loc var stack_nb_elts env
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
    compile_expr (loc, typ, Evar (Vident (typ, name))) stack_nb_elts env
  | Earray_init el ->
    let env = Env.malloc_array typ env in
    let previous_pointer = env.memory.previous_pointer in
    let stack_nb_elts, env =
      compile_array_init buf env.memory.previous_pointer typ el stack_nb_elts
        env
    in
    write_i32_const_u buf previous_pointer;
    Ok (buf, stack_nb_elts + 1, env)
  | Earray (var, expr) ->
    (* a[idx0][idx1] var = a[idx0] = sub_array pointer -- expr = sub_array field *)
    let* buf, stack_nb_elts, env = compile_var buf loc var stack_nb_elts env in
    let* stack_nb_elts, env =
      compile_array_pointer_from_pt buf expr stack_nb_elts env
    in
    write_load buf typ;
    Ok (buf, stack_nb_elts - 1, env)
  | Eread -> assert false
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
  | Estmt (loc, Sassert expr) ->
    let e_then = (loc, Tunit, Estmt (loc, Snop)) in
    let e_else = (loc, Tunit, Estmt (loc, Sunreachable)) in
    compile_expr (loc, Tunit, Eif (expr, e_then, e_else)) stack_nb_elts env
  | Estmt (_loc, Sprint expr) ->
    let* expr_buf, stack_nb_elts, env = compile_expr expr stack_nb_elts env in
    Buffer.add_buffer buf expr_buf;
    (* WIP: 1 ? *)
    write_call buf 0;
    Ok (buf, stack_nb_elts, env)
  | Estmt (_loc, Sunreachable) ->
    write_unreachable buf;
    Ok (buf, stack_nb_elts, env)
  | Estmt (_loc, Snop) ->
    write_nop buf;
    Ok (buf, stack_nb_elts, env)

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

let write_import_print_i32 () =
  let buf = Buffer.create 32 in
  (* ascii: "mod" *)
  write_bytes buf [ 109; 111; 100 ];
  (* ascii: "print_i32" *)
  write_bytes buf [ 112; 114; 105; 110; 116; 95; 105; 51; 50 ];
  Buffer.add_char buf '\x00';
  write_u32_of_int buf 0;
  buf

let write_import_section buf =
  let _print_i32_buf = write_import_print_i32 () in
  let import_buf = Buffer.create 16 in
  (* TODO: [ print_i32_buf ]*)
  write_vector import_buf [];
  write_section buf '\x02' import_buf

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
  let i32_valtype_buf = Buffer.create 16 in
  write_valtype i32_valtype_buf Ti32;
  (* hard-coded: functype start [][] et print_i32 [i32][] *)
  let functype_print_i32_buf = encode_functype [ i32_valtype_buf ] [] in
  let functype_start_buf = encode_functype [] [] in
  let* code_buf, env = encode_prog prog env in
  write_type_section buf [ functype_start_buf; functype_print_i32_buf ];
  write_import_section buf;
  (* hard-coded: start function idx = 0 (print_i32 function idx = 1) *)
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
