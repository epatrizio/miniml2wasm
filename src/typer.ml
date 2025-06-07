(* Static typer *)

open Ast
open Syntax

exception Typing_error of string

let error loc message =
  let message = Format.sprintf {|%s: %s|} (str_loc loc) message in
  raise (Typing_error message)

let typecheck_cst = function
  | Cunit -> Tunit
  | Cnil -> Tlist Tunknown
  | Cbool _b -> Tbool
  | Ci32 _i32 -> Ti32

let rec typecheck_unop_expr (loc, _typ, expr') env :
  (expr * (typ, _) Env.t, _) result =
  match expr' with
  | Eunop (Unot, expr) -> (
    let* (l, t, expr'), env = typecheck_expr expr env in
    match t with
    | Tbool | Tarray (Tbool, _) ->
      Ok ((loc, Tbool, Eunop (Unot, (l, t, expr'))), env)
    | _ -> error loc "attempt to perform unop 'not' on a non boolean type" )
  | Eunop (Uminus, expr) -> (
    let* (l, t, expr'), env = typecheck_expr expr env in
    match t with
    | Ti32 | Tarray (Ti32, _) ->
      Ok ((loc, Ti32, Eunop (Uminus, (l, t, expr'))), env)
    | _ -> error loc "attempt to perform unop '-' on a non i32 type" )
  | _ -> assert false (* call error *)

and typecheck_binop_expr (loc, _typ, expr') env :
  (expr * (typ, _) Env.t, _) result =
  let typecheck_binop_arith_expr binop e1 e2 env =
    let* (l1, typ1, e1'), env = typecheck_expr e1 env in
    let* (l2, typ2, e2'), env = typecheck_expr e2 env in
    match (typ1, typ2) with
    | Ti32, Ti32
    | Tarray (Ti32, _), Tarray (Ti32, _)
    | Ti32, Tarray (Ti32, _)
    | Tarray (Ti32, _), Ti32 ->
      Ok ((loc, Ti32, Ebinop ((l1, typ1, e1'), binop, (l2, typ2, e2'))), env)
    | _ ->
      let message =
        Format.sprintf
          {|attempt to perform an arithmetic binop '%s' on a non i32 types|}
          (str_binop binop)
      in
      error loc message
  in
  let typecheck_binop_bool_expr binop e1 e2 env =
    let* (l1, typ1, e1'), env = typecheck_expr e1 env in
    let* (l2, typ2, e2'), env = typecheck_expr e2 env in
    match (typ1, typ2) with
    | Tbool, Tbool ->
      Ok ((loc, Tbool, Ebinop ((l1, typ1, e1'), binop, (l2, typ2, e2'))), env)
    | _ ->
      let message =
        Format.sprintf
          {|attempt to perform a boolean binop '%s' on a non boolean types|}
          (str_binop binop)
      in
      error loc message
  in
  let typecheck_binop_comp_expr binop e1 e2 env =
    let* (l1, typ1, e1'), env = typecheck_expr e1 env in
    let* (l2, typ2, e2'), env = typecheck_expr e2 env in
    match (typ1, typ2) with
    | Ti32, Ti32 ->
      Ok ((loc, Tbool, Ebinop ((l1, typ1, e1'), binop, (l2, typ2, e2'))), env)
    | _ ->
      let message =
        Format.sprintf
          {|attempt to perform a comparaison binop '%s' on a non i32 types|}
          (str_binop binop)
      in
      error loc message
  in
  match expr' with
  | Ebinop (e1, Band, e2) -> typecheck_binop_bool_expr Band e1 e2 env
  | Ebinop (e1, Bor, e2) -> typecheck_binop_bool_expr Bor e1 e2 env
  | Ebinop (e1, Badd, e2) -> typecheck_binop_arith_expr Badd e1 e2 env
  | Ebinop (e1, Bsub, e2) -> typecheck_binop_arith_expr Bsub e1 e2 env
  | Ebinop (e1, Bmul, e2) -> typecheck_binop_arith_expr Bmul e1 e2 env
  | Ebinop (e1, Bdiv, e2) -> typecheck_binop_arith_expr Bdiv e1 e2 env
  | Ebinop (e1, Beq, e2) -> typecheck_binop_comp_expr Beq e1 e2 env
  | Ebinop (e1, Bneq, e2) -> typecheck_binop_comp_expr Bneq e1 e2 env
  | Ebinop (e1, Blt, e2) -> typecheck_binop_comp_expr Blt e1 e2 env
  | Ebinop (e1, Ble, e2) -> typecheck_binop_comp_expr Ble e1 e2 env
  | Ebinop (e1, Bgt, e2) -> typecheck_binop_comp_expr Bgt e1 e2 env
  | Ebinop (e1, Bge, e2) -> typecheck_binop_comp_expr Bge e1 e2 env
  | _ -> assert false (* call error *)

and typecheck_var loc var env =
  match var with
  | Vident (_, ident_name) ->
    let* typ = Env.get_type ident_name env in
    Ok ((typ, Vident (typ, ident_name)), env)
  | Varray (var, expr) ->
    let* (typ, var), env = typecheck_var loc var env in
    begin
      match typ with
      | Tarray (typ, _) ->
        let* (l1, t1, expr'), env = typecheck_expr expr env in
        begin
          match t1 with
          | Ti32 -> Ok ((typ, Varray (var, (l1, t1, expr'))), env)
          | _ ->
            error loc "attempt to perform an array access with a non i32 indice"
        end
      | _ -> error loc "attempt to perform an array access on a non array var"
    end

and typecheck_expr (loc, typ, expr') env : (expr * (typ, _) Env.t, _) result =
  match expr' with
  | Ecst c as cst ->
    let typ = typecheck_cst c in
    Ok ((loc, typ, cst), env)
  | Evar var ->
    let* (typ, var), env = typecheck_var loc var env in
    Ok ((loc, typ, Evar var), env)
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
    let _, _, e1' = e1 in
    begin
      match e1' with
      | Efun_import_init _ ->
        error loc "local scope import functions are not allowed"
      | Efun_init (true, _, _, _) ->
        error loc "local scope export functions are not allowed"
      | _ -> ()
    end;
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
  | Eref expr ->
    let* (l, t, e'), env = typecheck_expr expr env in
    Ok ((loc, Tref t, Eref (l, t, e')), env)
  | Ederef (_, ident_name) ->
    let* typ = Env.get_type ident_name env in
    begin
      match typ with
      | Tref typ -> Ok ((loc, typ, Ederef (Tref typ, ident_name)), env)
      | _ -> error loc "attempt to dereference a non reference type"
    end
  | Econs (expr_hd, expr_tl) ->
    let* (loc_tl, typ_tl, expr_tl'), env = typecheck_expr expr_tl env in
    begin
      match typ_tl with
      | Tlist typ_elt_list ->
        let* (loc_hd, typ_hd, expr_hd'), env = typecheck_expr expr_hd env in
        begin
          match typ_hd with
          | Tbool | Ti32 ->
            if typ_elt_list = Tunknown || typ_elt_list = typ_hd then
              Ok
                ( ( loc
                  , Tlist typ_hd
                  , Econs
                      ((loc_hd, typ_hd, expr_hd'), (loc_tl, typ_tl, expr_tl'))
                  )
                , env )
            else
              error loc
                "attempt to perform a cons operation with different types"
          | t ->
            let msg =
              Format.sprintf
                {|attempt to perform a cons operation with a non supported type (%s)|}
                (str_typ t)
            in
            error loc msg
        end
      | _ -> error loc "attempt to perform a cons operation on a non list var"
    end
  | Elist_hd expr_list ->
    let* (loc_list, typ_list, expr_list'), env = typecheck_expr expr_list env in
    begin
      match typ_list with
      | Tlist Tunknown ->
        error loc
          "attempt to perform a list_hd operation on a non typed list or an \
           empty list"
      | Tlist typ_elt ->
        Ok ((loc, typ_elt, Elist_hd (loc_list, typ_list, expr_list')), env)
      | _ ->
        error loc "attempt to perform a list_hd operation on a non list var"
    end
  | Elist_tl expr_list ->
    let* (loc_list, typ_list, expr_list'), env = typecheck_expr expr_list env in
    begin
      match typ_list with
      | Tlist Tunknown ->
        error loc
          "attempt to perform a list_tl operation on a non typed list or an \
           empty list"
      | Tlist _ as typ_l ->
        Ok ((loc, typ_l, Elist_tl (loc_list, typ_list, expr_list')), env)
      | _ ->
        error loc "attempt to perform a list_tl operation on a non list var"
    end
  | Elist_empty expr_list ->
    let* (loc_list, typ_list, expr_list'), env = typecheck_expr expr_list env in
    begin
      match typ_list with
      | Tlist _ ->
        Ok ((loc, Tbool, Elist_empty (loc_list, typ_list, expr_list')), env)
      | _ ->
        error loc "attempt to perform a list_empty operation on a non list var"
    end
  | Earray_init el ->
    if List.length el = 0 then error loc "attempt to init a zero-size array";
    let typ, el, _, env =
      List.fold_left
        (fun (typ, el, is_first, env) e ->
          let ret = typecheck_expr e env in
          match ret with
          | Ok ((l, t, e'), env) when (is_first && typ = Tunknown) || typ = t ->
            (t, el @ [ (l, t, e') ], false, env)
          | Ok (e, env) -> (Tunknown, el @ [ e ], false, env)
          | _ -> (Tunknown, el, false, env) )
        (Tunknown, [], true, env) el
    in
    begin
      match typ with
      | Tunit | Tref _ | Tunknown ->
        error loc "attempt to init an array with non supported/uniform types"
      | typ ->
        let size = List.length el in
        let size = Int32.of_int size in
        Ok ((loc, Tarray (typ, size), Earray_init el), env)
    end
  | Earray_size var ->
    let* (typ, var), env = typecheck_var loc var env in
    begin
      match typ with
      | Tarray _ -> Ok ((loc, Ti32, Earray_size var), env)
      | _ ->
        error loc "attempt to perform an array_size call on a non array var"
    end
  | Earray_make (cst_size, expr_init) -> begin
    match cst_size with
    | Ci32 size when size <= 0l ->
      error loc "attempt to perform a zero-size array_make"
    | Ci32 size -> begin
      let* (loc, typ, expr_init'), env = typecheck_expr expr_init env in
      match typ with
      | Ti32 ->
        Ok
          ( ( loc
            , Tarray (Ti32, size)
            , Earray_make (cst_size, (loc, Ti32, expr_init')) )
          , env )
      | Tbool ->
        Ok
          ( ( loc
            , Tarray (Tbool, size)
            , Earray_make (cst_size, (loc, Tbool, expr_init')) )
          , env )
      | _ ->
        error loc "attempt to perform an array_make with non supported type"
    end
    | _ -> error loc "attempt to perform an array_make with a non i32 type size"
  end
  | Earray_matrix_make (cst_size_x, cst_size_y, expr_init) -> begin
    match (cst_size_x, cst_size_y) with
    | Ci32 size_x, Ci32 size_y when size_x <= 0l || size_y <= 0l ->
      error loc "attempt to perform a x or y zero-size matrix_make"
    | Ci32 size_x, Ci32 size_y -> begin
      let* (loc, typ, expr_init'), env = typecheck_expr expr_init env in
      match typ with
      | Ti32 ->
        Ok
          ( ( loc
            , Tarray (Tarray (Ti32, size_y), size_x)
            , Earray_matrix_make
                (cst_size_x, cst_size_y, (loc, Ti32, expr_init')) )
          , env )
      | Tbool ->
        Ok
          ( ( loc
            , Tarray (Tarray (Tbool, size_y), size_x)
            , Earray_matrix_make
                (cst_size_x, cst_size_y, (loc, Tbool, expr_init')) )
          , env )
      | _ ->
        error loc "attempt to perform a matrix_make with non supported type"
    end
    | _ -> error loc "attempt to perform a matrix_make with a non i32 type size"
  end
  | Efun_init (is_export, idents, _typ, body) ->
    List.fold_left
      (fun _ (typ, _name) ->
        if typ = Tunknown then
          error loc
            "Inference is not possible in function definition, all arguments \
             must be typed!" )
      () idents;
    let args_typ, env =
      List.fold_left
        (fun (args_typ, env) (typ, name) ->
          let env = Env.set_type name typ env in
          (args_typ @ [ typ ], env) )
        ([], env) idents
    in
    let* typ_body, body, env = typecheck_block body env in
    begin
      match (typ, typ_body) with
      | typ, typ_body
        when (typ_body = Tunit || typ_body = Tbool || typ_body = Ti32)
             && (typ = Tunknown || typ = typ_body) ->
        Ok
          ( ( loc
            , Tfun (args_typ, typ_body)
            , Efun_init (is_export, idents, typ_body, body) )
          , env )
      | typ, Tarray (ident_typ, size)
        when typ = Tunknown || typ = Tarray (ident_typ, size) ->
        Ok
          ( ( loc
            , Tfun (args_typ, typ_body)
            , Efun_init (is_export, idents, typ_body, body) )
          , env )
      | typ, typ_body when typ != Tunknown && typ_body != typ ->
        let msg =
          Format.sprintf
            {|function signature (return type) and body type are not uniform. %s expected!|}
            (str_typ typ)
        in
        error loc msg
      | _ -> assert false
    end
  | Efun_import_init fun_typ as fun_import -> begin
    match fun_typ with
    | Tfun (_typs, Tunknown) ->
      error loc "return type of an import function must be specified"
    | Tfun (typs, _typ) as fun_typ ->
      List.iter
        (fun typ ->
          if typ = Tunknown then
            error loc "arguments types of an import function must be specified"
          else () )
        typs;
      Ok ((loc, fun_typ, fun_import), env)
    | _ -> error loc "attempt to perform an import on a non function type"
  end
  | Efun_call ((_ident_typ, ident_name), el) ->
    let* ident_typ = Env.get_type ident_name env in
    begin
      match ident_typ with
      | Tfun (typ_l, typ_body) ->
        ( if List.length typ_l != List.length el then
            let msg =
              Format.sprintf
                {|function signature and function call are not uniform. %d argument(s) expected!|}
                (List.length typ_l)
            in
            error loc msg );
        let el, env =
          List.fold_left2
            (fun (el, env) typ_fun_arg exp_arg ->
              let ret = typecheck_expr exp_arg env in
              match ret with
              | Ok ((loc, typ_exp, _exp'), env) when typ_fun_arg = typ_exp ->
                (el @ [ (loc, typ_exp, _exp') ], env)
              | _ ->
                error loc
                  "attempt to perform a function call with non uniform \
                   argument types!" )
            ([], env) typ_l el
        in
        Ok ((loc, typ_body, Efun_call ((ident_typ, ident_name), el)), env)
      | _ ->
        error loc "attempt to perform a function call on a non function var"
    end
  | Estmt stmt ->
    let* stmt, env = typecheck_stmt stmt env in
    Ok ((loc, Tunit, Estmt stmt), env)

and typecheck_block block env : (typ * block * (typ, _) Env.t, _) result =
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

and typecheck_stmt (loc, stmt') env : (stmt * (typ, _) Env.t, _) result =
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
  | Sassign (Vident (_, ident_name), expr) ->
    let* ident_typ = Env.get_type ident_name env in
    let* (loc_e, typ_e, expr'), env = typecheck_expr expr env in
    begin
      match (ident_typ, typ_e) with
      | Tref typ, typ_e when typ = typ_e ->
        Ok
          ( ( loc
            , Sassign (Vident (ident_typ, ident_name), (loc_e, typ_e, expr')) )
          , env )
      | _ ->
        error loc "attempt to perform a ref assignment with different types"
    end
  | Sassign ((Varray (_, _) as var), expr) ->
    let* (var_typ, var), _env = typecheck_var loc var env in
    let* (l, expr_typ, expr'), env = typecheck_expr expr env in
    if var_typ = expr_typ then
      Ok ((loc, Sassign (var, (l, expr_typ, expr'))), env)
    else error loc "attempt to perform an array assignment with different types"
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
  | Sassert expr -> (
    let* (loc_e, typ_e, expr'), env = typecheck_expr expr env in
    match typ_e with
    | Tbool -> Ok ((loc, Sassert (loc_e, typ_e, expr')), env)
    | typ ->
      let message =
        Format.sprintf
          {|attempt to perform an assert call on a non boolean value (%s)|}
          (str_typ typ)
      in
      error loc message )
  | Sunreachable -> Ok ((loc, Sunreachable), env)
  | Snop -> Ok ((loc, Snop), env)

let typecheck_prog prog env : (prog * (typ, _) Env.t, _) result =
  let* _typ, prog, env = typecheck_block prog env in
  Ok (prog, env)
