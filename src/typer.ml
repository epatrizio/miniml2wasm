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

let rec typecheck_expr (loc, typ, expr') : (expr, _) result =
  match expr' with
  | Ecst c as cst ->
    let typ = typecheck_cst c in
    Ok (loc, typ, cst)
  | Eident _i as ident -> Ok (loc, typ, ident)
  | Eunop (unop, expr) ->
    let* l, t, expr' = typecheck_expr expr in
    begin
      match unop with
      | Unot -> (
        match t with
        | Tbool -> Ok (loc, Tbool, Eunop (Unot, (l, t, expr')))
        | _ -> error loc "attempt to perform unop 'not' on a non boolean type" )
    end
  | Ebinop (e1, binop, e2) ->
    let* l1, typ1, e1' = typecheck_expr e1 in
    let* l2, typ2, e2' = typecheck_expr e2 in
    begin
      match binop with
      | Badd -> (
        match (typ1, typ2) with
        | Ti32, Ti32 ->
          Ok (loc, Ti32, Ebinop ((l1, typ1, e1'), Badd, (l2, typ2, e2')))
        | _ -> error loc "attempt to perform binop 'add' on a non i32 types" )
      | _ -> assert false (* TODO *)
    end

and typecheck_stmt (loc, _typ, stmt') : (stmt, _) result =
  match stmt' with
  | Sassign ((ident_typ, ident_name), expr, stmt) ->
    let* loc_e, typ_e, expr' = typecheck_expr expr in
    let* stmt = typecheck_stmt stmt in
    begin
      match (ident_typ, typ_e) with
      | Tunknown, typ_e ->
        Ok
          ( loc
          , Tunit
          , Sassign ((typ_e, ident_name), (loc_e, typ_e, expr'), stmt) )
      | ident_typ, typ_e when ident_typ = typ_e ->
        Ok
          ( loc
          , Tunit
          , Sassign ((typ_e, ident_name), (loc_e, typ_e, expr'), stmt) )
      | _ -> error loc "attempt to perform an assignment with different types"
    end
  | Sblock block ->
    let* typ_b, block = typecheck_block block in
    Ok (loc, typ_b, Sblock block)
  | Sif (expr, s1, s2) ->
    let* l_cond, typ_cond, expr' = typecheck_expr expr in
    begin
      match typ_cond with
      | Tbool ->
        let* l1, typ1, s1' = typecheck_stmt s1 in
        let* l2, typ2, s2' = typecheck_stmt s2 in
        begin
          match (typ1, typ2) with
          | typ1, typ2 when typ1 = typ2 ->
            Ok
              ( loc
              , typ1
              , Sif ((l_cond, Tbool, expr'), (l1, typ1, s1'), (l2, typ2, s2'))
              )
          | _ ->
            error loc
              "attempt to perform a if statement whose 2 branches do not have \
               the same type"
        end
      | _ -> error loc "attempt to perform a non boolean if condition"
    end
  | Swhile (_expr, _block) -> assert false
  | Sprint expr ->
    let* expr = typecheck_expr expr in
    Ok (loc, Tunit, Sprint expr)

and typecheck_block block : (typ * block, _) result =
  match block with
  | Bstmt stmt ->
    let* loc, typ, stmt' = typecheck_stmt stmt in
    Ok (typ, Bstmt (loc, typ, stmt'))
  | Bseq (stmt, block) -> (
    let* loc, typ, stmt' = typecheck_stmt stmt in
    match typ with
    | Tunit ->
      let* t, b = typecheck_block block in
      Ok (t, Bseq ((loc, Tunit, stmt'), b))
    | _ -> error loc "unit type expected in the left-hand side of a sequence" )

and typecheck_prog prog = typecheck_stmt prog
