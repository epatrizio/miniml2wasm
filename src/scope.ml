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

and analyse_stmt (loc, typ, stmt') env =
  match stmt' with
  | Sassign ((typ_ident, name), expr, stmt) ->
    let fresh_name, env = Env.add_local name env in
    let* expr, env = analyse_expr expr env in
    let* stmt, env = analyse_stmt stmt env in
    Ok ((loc, typ, Sassign ((typ_ident, fresh_name), expr, stmt)), env)
  | Sblock block ->
    let* block, env = analyse_block block env in
    Ok ((loc, typ, Sblock block), env)
  | Sif (expr, s1, s2) ->
    let* expr, env = analyse_expr expr env in
    let* s1, env = analyse_stmt s1 env in
    let* s2, env = analyse_stmt s2 env in
    Ok ((loc, typ, Sif (expr, s1, s2)), env)
  | Swhile (expr, block) ->
    let* expr, env = analyse_expr expr env in
    let* block, env = analyse_block block env in
    Ok ((loc, typ, Swhile (expr, block)), env)
  | Sprint expr ->
    let* expr, env = analyse_expr expr env in
    Ok ((loc, typ, Sprint expr), env)

and analyse_block block env =
  match block with
  | Bstmt stmt ->
    let* stmt, env = analyse_stmt stmt env in
    Ok (Bstmt stmt, env)
  | Bseq (stmt, block) ->
    let* stmt, env = analyse_stmt stmt env in
    let* block, env = analyse_block block env in
    Ok (Bseq (stmt, block), env)

let analysis = analyse_stmt
