(* Static analysis: unused vars *)

open Ast
open Syntax
module SMap = Map.Make (String)

type variables_use =
  { globals : int SMap.t
  ; locals : int SMap.t
  }

let add_global name vars_use =
  let globals = SMap.add name 0 vars_use.globals in
  { vars_use with globals }

let add_local name vars_use =
  let locals = SMap.add name 0 vars_use.locals in
  { vars_use with locals }

let use_var name vars_use =
  match SMap.find_opt name vars_use.locals with
  | Some nb ->
    let locals = SMap.add name (nb + 1) vars_use.locals in
    Ok { vars_use with locals }
  | None -> (
    match SMap.find_opt name vars_use.globals with
    | Some nb ->
      let globals = SMap.add name (nb + 1) vars_use.globals in
      Ok { vars_use with globals }
    | None ->
      Error (Format.sprintf "ident: %s not found or not in current scope" name)
    )

let print_analysis vars_use =
  SMap.iter
    (fun name nb ->
      if nb = 0 then print_endline ("Warning: unused global variable " ^ name) )
    vars_use.globals;
  SMap.iter
    (fun name nb ->
      if nb = 0 then print_endline ("Warning: unused local variable " ^ name) )
    vars_use.locals

let empty () =
  let globals = SMap.empty in
  let locals = SMap.empty in
  { globals; locals }

(* ********************************************* *)

let rec analyse_var var vars_use =
  match var with
  | Vident (_typ_ident, name) -> use_var name vars_use
  | Varray ((_typ_ident, name), expr) ->
    let* vars_use = use_var name vars_use in
    analyse_expr expr vars_use

and analyse_expr (_loc, _typ, expr') vars_use =
  match expr' with
  | Ecst _cst -> Ok vars_use
  | Evar var -> analyse_var var vars_use
  | Eunop (_unop, expr) -> analyse_expr expr vars_use
  | Ebinop (e1, _binop, e2) ->
    let* vars_use = analyse_expr e1 vars_use in
    analyse_expr e2 vars_use
  | Eblock block -> analyse_block block vars_use
  | Eif (e_cond, e_then, e_else) ->
    let* vars_use = analyse_expr e_cond vars_use in
    let* vars_use = analyse_expr e_then vars_use in
    analyse_expr e_else vars_use
  | Elet ((_typ_ident, name), e1, e2) ->
    let* vars_use = analyse_expr e1 vars_use in
    let vars_use = add_local name vars_use in
    analyse_expr e2 vars_use
  | Eref expr -> analyse_expr expr vars_use
  | Ederef (_typ_ident, name) -> use_var name vars_use
  | Earray_init el ->
    let vars_use =
      List.fold_left
        (fun vars_use expr ->
          let ret = analyse_expr expr vars_use in
          match ret with Ok vars_use -> vars_use | _ -> assert false )
        vars_use el
    in
    Ok vars_use
  | Earray (var, expr) ->
    let* vars_use = analyse_var var vars_use in
    analyse_expr expr vars_use
  | Earray_size (_typ_ident, name) -> use_var name vars_use
  | Efun_init (_is_export, idents, _typ, body) ->
    let vars_use =
      List.fold_left
        (fun vars_use (_typ_ident, name) -> add_local name vars_use)
        vars_use idents
    in
    analyse_block body vars_use
  | Efun_import_init _typ -> Ok vars_use
  | Efun_call ((_typ_ident, name), el) ->
    let* vars_use = use_var name vars_use in
    let vars_use =
      List.fold_left
        (fun vars_use expr ->
          let ret = analyse_expr expr vars_use in
          match ret with Ok vars_use -> vars_use | _ -> assert false )
        vars_use el
    in
    Ok vars_use
  | Estmt stmt -> analyse_stmt stmt vars_use

and analyse_block block vars_use =
  match block with
  | Bexpr expr -> analyse_expr expr vars_use
  | Bseq (expr, block) ->
    let* vars_use = analyse_expr expr vars_use in
    analyse_block block vars_use

and analyse_stmt (_loc, stmt') vars_use =
  match stmt' with
  | Slet ((_typ_ident, name), expr) ->
    let* vars_use = analyse_expr expr vars_use in
    Ok (add_global name vars_use)
  | Srefassign ((_typ_ident, name), expr) ->
    let* vars_use = analyse_expr expr vars_use in
    use_var name vars_use
  | Sarrayassign ((_typ_ident, name), e1, e2) ->
    let* vars_use = analyse_expr e1 vars_use in
    let* vars_use = analyse_expr e2 vars_use in
    use_var name vars_use
  | Swhile (expr, block) ->
    let* vars_use = analyse_expr expr vars_use in
    analyse_block block vars_use
  | Sassert expr -> analyse_expr expr vars_use
  | Sunreachable -> Ok vars_use
  | Snop -> Ok vars_use

let analysis prog =
  let vars_use = empty () in
  analyse_block prog vars_use
