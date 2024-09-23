(* Static typer *)

open Ast
open Syntax

exception Typing_error of string

let error loc message =
  let message = Format.sprintf {|%s: %s|} (str_loc loc) message in
  raise (Typing_error message)

let typecheck_cst = function
  | Cunit -> Tunit
  | Cbool _b -> Tbool
  | Ci32 _i32 -> Ti32

let rec typecheck_unop_expr (loc, _typ, expr') env :
  (expr * typ Env.t, _) result =
  match expr' with
  | Eunop (Unot, expr) -> (
    let* (l, t, expr'), env = typecheck_expr expr env in
    match t with
    | Tbool -> Ok ((loc, Tbool, Eunop (Unot, (l, t, expr'))), env)
    | _ -> error loc "attempt to perform unop 'not' on a non boolean type" )
  | Eunop (Uminus, expr) -> (
    let* (l, t, expr'), env = typecheck_expr expr env in
    match t with
    | Ti32 -> Ok ((loc, Ti32, Eunop (Uminus, (l, t, expr'))), env)
    | _ -> error loc "attempt to perform unop '-' on a non i32 type" )
  | _ -> assert false (* call error *)

and typecheck_binop_expr (loc, _typ, expr') env : (expr * typ Env.t, _) result =
  let typecheck_binop_arith_expr binop e1 e2 env =
    let* (l1, typ1, e1'), env = typecheck_expr e1 env in
    let* (l2, typ2, e2'), env = typecheck_expr e2 env in
    match (typ1, typ2) with
    | Ti32, Ti32 ->
      Ok ((loc, Ti32, Ebinop ((l1, typ1, e1'), binop, (l2, typ2, e2'))), env)
    | _ ->
      let message =
        Format.sprintf
          {|attempt to perform an arithmetic binop '%s' on a non i32 types|}
          (str_binop binop)
      in
      error loc message
  in
  match expr' with
  | Ebinop (e1, Badd, e2) -> typecheck_binop_arith_expr Badd e1 e2 env
  | Ebinop (e1, Bsub, e2) -> typecheck_binop_arith_expr Bsub e1 e2 env
  | Ebinop (e1, Bmul, e2) -> typecheck_binop_arith_expr Bmul e1 e2 env
  | Ebinop (e1, Bdiv, e2) -> typecheck_binop_arith_expr Bdiv e1 e2 env
  | Ebinop (_e1, binop, _e2) ->
    let message =
      Format.sprintf {|binop '%s': to be implemented!|} (str_binop binop)
    in
    error loc message
  | _ -> assert false (* call error *)

and typecheck_expr (loc, typ, expr') env : (expr * typ Env.t, _) result =
  match expr' with
  | Ecst c as cst ->
    let typ = typecheck_cst c in
    Ok ((loc, typ, cst), env)
  | Eident (_typ, name) as ident ->
    let* typ = Env.get_type name env in
    Ok ((loc, typ, ident), env)
  | Eunop (_unop, _expr) as unop_expr ->
    typecheck_unop_expr (loc, typ, unop_expr) env
  | Ebinop (_e1, _binop, _e2) as binop_expr ->
    typecheck_binop_expr (loc, typ, binop_expr) env
  | Eblock block ->
    let* typ_b, block, env = typecheck_block block env in
    Ok ((loc, typ_b, Eblock block), env)
  | Eif (e_cond, e_then, e_else) ->
    let* (l_cond, typ_cond, e_cond'), env = typecheck_expr e_cond env in
    begin
      match typ_cond with
      | Tbool ->
        let* (l_then, typ_then, e_then'), env = typecheck_expr e_then env in
        let* (l_else, typ_else, e_else'), env = typecheck_expr e_else env in
        begin
          match (typ_then, typ_else) with
          | typ_then, typ_else when typ_then = typ_else ->
            Ok
              ( ( loc
                , typ_then
                , Eif
                    ( (l_cond, Tbool, e_cond')
                    , (l_then, typ_then, e_then')
                    , (l_else, typ_else, e_else') ) )
              , env )
          | _ ->
            error loc
              "attempt to perform a if expression whose 2 branches do not have \
               the same type"
        end
      | _ ->
        error loc "attempt to perform a non boolean if expression condition"
    end
  | Elet ((ident_typ, ident_name), e1, e2) ->
    let* (loc_e1, typ_e1, e1'), env = typecheck_expr e1 env in
    begin
      match (ident_typ, typ_e1) with
      | ident_typ, typ_e1 when ident_typ = typ_e1 || ident_typ = Tunknown ->
        let env = Env.set_type ident_name typ_e1 env in
        let* (l, t, e2'), env = typecheck_expr e2 env in
        Ok
          ( ( loc
            , t
            , Elet ((typ_e1, ident_name), (loc_e1, typ_e1, e1'), (l, t, e2')) )
          , env )
      | _ -> error loc "attempt to perform an assignment with different types"
    end
  | Estmt stmt ->
    let* stmt, env = typecheck_stmt stmt env in
    Ok ((loc, Tunit, Estmt stmt), env)

and typecheck_block block env : (typ * block * typ Env.t, _) result =
  match block with
  | Bexpr expr ->
    let* (loc, typ, expr'), env = typecheck_expr expr env in
    Ok (typ, Bexpr (loc, typ, expr'), env)
  | Bseq (expr, block) -> (
    let* (loc, typ, expr'), env = typecheck_expr expr env in
    match typ with
    | Tunit ->
      let* t, b, env = typecheck_block block env in
      Ok (t, Bseq ((loc, Tunit, expr'), b), env)
    | _ -> error loc "unit type expected in the left-hand side of a sequence" )

and typecheck_stmt (loc, stmt') env : (stmt * typ Env.t, _) result =
  match stmt' with
  | Slet ((ident_typ, ident_name), expr) ->
    let* (loc_e, typ_e, e'), env = typecheck_expr expr env in
    begin
      match (ident_typ, typ_e) with
      | ident_typ, typ_e when ident_typ = typ_e || ident_typ = Tunknown ->
        let env = Env.set_type ident_name typ_e env in
        Ok ((loc, Slet ((typ_e, ident_name), (loc_e, typ_e, e'))), env)
      | _ -> error loc "attempt to perform an assignment with different types"
    end
  | Swhile (expr, block) ->
    let* (loc_e, typ_e, expr'), env = typecheck_expr expr env in
    begin
      match typ_e with
      | Tbool ->
        let* typ_b, block, env = typecheck_block block env in
        begin
          match typ_b with
          | Tunit -> Ok ((loc, Swhile ((loc_e, typ_e, expr'), block)), env)
          | _ -> error loc "type unit is expected in the body of a while-loop"
        end
      | _ -> error loc "type bool is expected in the condition of a while-loop"
    end
  | Sprint expr ->
    let* expr, env = typecheck_expr expr env in
    Ok ((loc, Sprint expr), env)

let typecheck_prog prog env : (prog * typ Env.t, _) result =
  let* _typ, prog, env = typecheck_block prog env in
  Ok (prog, env)
