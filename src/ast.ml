(* Abstract Syntax Tree *)

type location = Lexing.position * Lexing.position

type typ =
  | Tunit
  | Tbool
  | Ti32
  | Tref of typ
  | Tlist of typ
  | Tarray of typ * Int32.t
  | Tfun of typ list * typ
  | Tunknown

type ident = typ * string

type unop =
  | Unot
  | Uminus

type binop =
  | Band
  | Bor
  | Badd
  | Bsub
  | Bmul
  | Bdiv
  | Beq
  | Bneq
  | Blt
  | Ble
  | Bgt
  | Bge

type cst =
  | Cunit
  | Cnil
  | Cbool of bool
  | Ci32 of Int32.t

type expr = location * typ * expr'

and var =
  | Vident of ident
  | Varray of var * expr

and expr' =
  | Ecst of cst
  | Evar of var
  | Eunop of unop * expr
  | Ebinop of expr * binop * expr
  | Eblock of block
  | Eif of expr * expr * expr
  | Elet of ident * expr * expr
  | Eref of expr
  | Ederef of ident
  | Econs of expr * expr
  | Elist_hd of expr
  | Elist_tl of expr
  | Elist_empty of expr
  | Earray_init of expr list
  | Earray_size of var
  | Earray_make of cst * expr
  | Earray_matrix_make of cst * cst * expr
  | Efun_init of bool * ident list * typ * block
  | Efun_import_init of typ
  | Efun_call of ident * expr list
  | Estmt of stmt (* stmt should be seen as an expr of type unit. OK? *)

and block =
  | Bexpr of expr
  | Bseq of expr * block

and stmt = location * stmt'

and stmt' =
  | Slet of ident * expr
  | Sassign of var * expr
  | Swhile of expr * block
  | Sassert of expr
  | Sunreachable
  | Snop

type prog = block

(* pretty printer *)

open Format

let pp_sep fmt () = fprintf fmt ", "

let rec str_typ = function
  | Tunit -> "unit"
  | Tbool -> "bool"
  | Ti32 -> "i32"
  | Tlist typ -> sprintf {|%s list|} (str_typ typ)
  | Tarray (typ, i) -> sprintf {|%s[%d]|} (str_typ typ) (Int32.to_int i)
  | Tfun (arg_typs, ret_typ) ->
    let arg_typs = if List.length arg_typs = 0 then [ Tunit ] else arg_typs in
    let typs = arg_typs @ [ ret_typ ] in
    let typs = List.map str_typ typs in
    String.concat " -> " typs
  | Tunknown -> "unknown_type"
  | _ -> assert false

let print_typ fmt typ =
  pp_print_string fmt
  @@
  match typ with
  | Tref typ -> sprintf {|%s ref|} (str_typ typ)
  | typ -> str_typ typ

let print_ident fmt ?(typ_display = false) ((typ, name) as _ident : ident) =
  if typ_display then fprintf fmt {|%s : %a|} name print_typ typ
  else fprintf fmt {|%s|} name

let print_unop fmt unop =
  pp_print_string fmt @@ match unop with Unot -> "not" | Uminus -> "-"

let str_binop = function
  | Band -> "&&"
  | Bor -> "||"
  | Badd -> "+"
  | Bsub -> "-"
  | Bmul -> "*"
  | Bdiv -> "/"
  | Beq -> "=="
  | Bneq -> "!="
  | Blt -> "<"
  | Ble -> "<="
  | Bgt -> ">"
  | Bge -> ">="

let print_binop fmt binop = pp_print_string fmt (str_binop binop)

let print_cst fmt = function
  | Cunit -> pp_print_string fmt "()"
  | Cnil -> pp_print_string fmt "nil"
  | Cbool b -> pp_print_bool fmt b
  | Ci32 i32 -> pp_print_int fmt (Int32.to_int i32)

let rec print_var fmt = function
  | Vident ident -> print_ident fmt ident
  | Varray (var, expr) -> fprintf fmt {|%a[%a]|} print_var var print_expr expr

and print_expr fmt (_, _, expr) =
  match expr with
  | Ecst cst -> print_cst fmt cst
  | Evar var -> print_var fmt var
  | Eunop (unop, e) -> fprintf fmt {|%a %a|} print_unop unop print_expr e
  | Ebinop (e1, binop, e2) ->
    fprintf fmt {|%a %a %a|} print_expr e1 print_binop binop print_expr e2
  | Eblock block -> fprintf fmt {|begin@.@[<v 2>%a@]@.end|} print_block block
  | Eif (e_cond, e_then, e_else) ->
    fprintf fmt {|if %a then %a else %a|} print_expr e_cond print_expr e_then
      print_expr e_else
  | Elet (ident, e1, e2) ->
    fprintf fmt {|let %a = %a in@.@[<v 2>%a@]|}
      (print_ident ~typ_display:true)
      ident print_expr e1 print_expr e2
  | Eref e -> fprintf fmt {|ref %a|} print_expr e
  | Ederef ident -> fprintf fmt {|!%a|} (print_ident ~typ_display:false) ident
  | Econs (expr_hd, expr_tl) ->
    fprintf fmt {|%a :: %a|} print_expr expr_hd print_expr expr_tl
  | Elist_hd expr_list -> fprintf fmt {|list_hd %a|} print_expr expr_list
  | Elist_tl expr_list -> fprintf fmt {|list_tl %a|} print_expr expr_list
  | Elist_empty expr_list -> fprintf fmt {|list_empty %a|} print_expr expr_list
  | Earray_init el -> fprintf fmt "[%a]" (pp_print_list ~pp_sep print_expr) el
  | Earray_size var -> fprintf fmt {|array_size %a|} print_var var
  | Earray_make (cst_size, expr_init) ->
    fprintf fmt {|array_make %a %a|} print_cst cst_size print_expr expr_init
  | Earray_matrix_make (cst_size_x, cst_size_y, expr_init) ->
    fprintf fmt {|matrix_make %a %a %a|} print_cst cst_size_x print_cst
      cst_size_y print_expr expr_init
  | Efun_init (is_export, idents, typ, body) ->
    fprintf fmt {|%sfun(%a) : %a {@.@[<v 2>%a@]@.}|}
      (if is_export then "export " else "")
      (pp_print_list ~pp_sep (print_ident ~typ_display:true))
      idents print_typ typ print_block body
  | Efun_import_init typ -> begin
    match typ with
    | Tfun (typs, typ) ->
      fprintf fmt {|import fun(%a) : %a|}
        (pp_print_list ~pp_sep print_typ)
        typs print_typ typ
    | _ -> assert false
  end
  | Efun_call (ident, el) ->
    fprintf fmt "%a(%a)"
      (print_ident ~typ_display:false)
      ident
      (pp_print_list ~pp_sep print_expr)
      el
  | Estmt stmt -> fprintf fmt {|%a|} print_stmt stmt

and print_stmt fmt (_, stmt) =
  match stmt with
  | Slet (ident, expr) ->
    fprintf fmt {|let %a = %a|}
      (print_ident ~typ_display:true)
      ident print_expr expr
  | Sassign (var, expr) ->
    fprintf fmt {|%a := %a|} print_var var print_expr expr
  | Swhile (expr, block) ->
    fprintf fmt {|while %a do %a done|} print_expr expr print_block block
  | Sassert expr -> fprintf fmt {|assert %a|} print_expr expr
  | Sunreachable -> fprintf fmt {|unreachable|}
  | Snop -> fprintf fmt {|nop|}

and print_block fmt = function
  | Bexpr expr -> print_expr fmt expr
  | Bseq (expr, block) ->
    fprintf fmt {|%a;@.%a|} print_expr expr print_block block

and print_block_typ fmt = function
  | Bexpr (_loc, typ, _expr') -> print_typ fmt typ
  | Bseq (_expr, block) -> print_block_typ fmt block

let print_prog fmt block = fprintf fmt {|@[<v 2>%a@]@.|} print_block block

let str_loc (loc : location) =
  let start, _end = loc in
  let file = start.pos_fname in
  let line = start.pos_lnum in
  let char = start.pos_cnum - start.pos_bol in
  sprintf {|File "%s", line %d, char %d|} file line char

let pp_loc fmt (loc : location) = pp_print_string fmt (str_loc loc)
