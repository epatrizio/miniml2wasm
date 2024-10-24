(* Scope analysis *)

open Ast
open Syntax

let rec analyse_expr (loc, typ, expr') env =
  match expr' with
  | Ecst _cst as ecst -> Ok ((loc, typ, ecst), env)
  | Eident (typ_ident, name) ->
    let* name = Env.get_name name env in
    Ok ((loc, typ, Eident (typ_ident, name)), env)
  | Eunop (unop, expr) ->
    let* expr, env = analyse_expr expr env in
    Ok ((loc, typ, Eunop (unop, expr)), env)
  | Ebinop (e1, binop, e2) ->
    let* e1, env = analyse_expr e1 env in
    let* e2, env = analyse_expr e2 env in
    Ok ((loc, typ, Ebinop (e1, binop, e2)), env)
  | Eblock block ->
    (* _env: block local scope *)
    let* block, _env = analyse_block block env in
    Ok ((loc, typ, Eblock block), env)
  | Eif (e_cond, e_then, e_else) ->
    let* e_cond, env = analyse_expr e_cond env in
    let* e_then, env = analyse_expr e_then env in
    let* e_else, env = analyse_expr e_else env in
    Ok ((loc, typ, Eif (e_cond, e_then, e_else)), env)
  | Elet ((typ_ident, name), e1, e2) ->
    (* _env_local: let local scope *)
    let* e1, env_local = analyse_expr e1 env in
    let fresh_name, env_local = Env.add_local name env_local in
    let* e2, _env_local = analyse_expr e2 env_local in
    Ok ((loc, typ, Elet ((typ_ident, fresh_name), e1, e2)), env)
  | Eref expr ->
    let* expr, env = analyse_expr expr env in
    Ok ((loc, typ, Eref expr), env)
  | Ederef (typ_ident, name) ->
    let* name = Env.get_name name env in
    Ok ((loc, typ, Ederef (typ_ident, name)), env)
  | Earray_init el ->
    let el, env =
      List.fold_left
        (fun (el, env) e ->
          let ret = analyse_expr e env in
          match ret with Ok (e, env) -> (el @ [ e ], env) | _ -> assert false )
        ([], env) el
    in
    Ok ((loc, typ, Earray_init el), env)
  | Earray ((typ_ident, name), expr) ->
    let* name = Env.get_name name env in
    let* expr, env = analyse_expr expr env in
    Ok ((loc, typ, Earray ((typ_ident, name), expr)), env)
  | Estmt stmt ->
    let* stmt, env = analyse_stmt stmt env in
    Ok ((loc, typ, Estmt stmt), env)

and analyse_block block env =
  match block with
  | Bexpr expr ->
    let* expr, env = analyse_expr expr env in
    Ok (Bexpr expr, env)
  | Bseq (expr, block) ->
    let* expr, env = analyse_expr expr env in
    let* block, env = analyse_block block env in
    Ok (Bseq (expr, block), env)

and analyse_stmt (loc, stmt') env =
  match stmt' with
  | Slet ((typ_ident, name), expr) ->
    let* expr, env = analyse_expr expr env in
    let fresh_name, env = Env.add_global name env in
    Ok ((loc, Slet ((typ_ident, fresh_name), expr)), env)
  | Srefassign ((typ_ident, name), expr) ->
    let* expr, env = analyse_expr expr env in
    let* name = Env.get_name name env in
    Ok ((loc, Srefassign ((typ_ident, name), expr)), env)
  | Sarrayassign ((typ_ident, name), e1, e2) ->
    let* e1, env = analyse_expr e1 env in
    let* e2, env = analyse_expr e2 env in
    let* name = Env.get_name name env in
    Ok ((loc, Sarrayassign ((typ_ident, name), e1, e2)), env)
  | Swhile (expr, block) ->
    let* expr, env = analyse_expr expr env in
    let* block, env = analyse_block block env in
    Ok ((loc, Swhile (expr, block)), env)
  | Sarray_size (typ_ident, name) ->
    let* name = Env.get_name name env in
    Ok ((loc, Sarray_size (typ_ident, name)), env)
  | Sprint expr ->
    let* expr, env = analyse_expr expr env in
    Ok ((loc, Sprint expr), env)

let analysis = analyse_block
