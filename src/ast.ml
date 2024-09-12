(* Abstract Syntax Tree *)

type location = Lexing.position * Lexing.position

type typ =
  | Tunit
  | Tbool
  | Ti32
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
  | Cbool of bool
  | Ci32 of Int32.t

type expr = location * typ * expr'

and expr' =
  | Ecst of cst
  | Eident of ident
  | Eunop of unop * expr
  | Ebinop of expr * binop * expr
  | Eblock of block
  | Eif of expr * expr * expr
  | Elet of stmt * expr
  | Estmt of stmt (* stmt should be seen as an expr of type unit. OK? *)

and block =
  | Bexpr of expr
  | Bseq of expr * block

and stmt = location * stmt'

and stmt' =
  | Sassign of ident * expr
  | Swhile of expr * block
  | Sprint of expr

type prog = expr

(* pretty printer *)

open Format

let print_typ fmt typ =
  pp_print_string fmt
  @@
  match typ with
  | Tunit -> "unit"
  | Tbool -> "bool"
  | Ti32 -> "i32"
  | Tunknown -> "unknown_type"

let print_ident fmt ?(typ_display = false) ((typ, name) as _ident : ident) =
  if typ_display then fprintf fmt {|%s: %a|} name print_typ typ
  else fprintf fmt {|%s|} name

let print_unop fmt unop =
  pp_print_string fmt @@ match unop with Unot -> "not" | Uminus -> "-"

let print_binop fmt binop =
  pp_print_string fmt
  @@
  match binop with
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

let print_cst fmt = function
  | Cunit -> pp_print_string fmt "()"
  | Cbool b -> pp_print_bool fmt b
  | Ci32 i32 -> pp_print_int fmt (Int32.to_int i32)

let rec print_expr fmt (_, _, expr) =
  match expr with
  | Ecst cst -> print_cst fmt cst
  | Eident ident -> print_ident fmt ident
  | Eunop (unop, e) -> fprintf fmt {|%a %a|} print_unop unop print_expr e
  | Ebinop (e1, binop, e2) ->
    fprintf fmt {|%a %a %a|} print_expr e1 print_binop binop print_expr e2
  | Eblock block -> print_block fmt block
  | Eif (e_cond, e_then, e_else) ->
    fprintf fmt {|if %a then %a else %a|} print_expr e_cond print_expr e_then
      print_expr e_else
  | Elet (stmt_assign, expr) ->
    fprintf fmt {|let %a in@.@[<v 2>%a@]|} print_stmt stmt_assign print_expr
      expr
  | Estmt stmt -> fprintf fmt {|%a|} print_stmt stmt

and print_stmt fmt (_, stmt) =
  match stmt with
  | Sassign (ident, expr) ->
    fprintf fmt {|%a = %a|}
      (print_ident ~typ_display:true)
      ident print_expr expr
  | Swhile (expr, block) ->
    fprintf fmt {|while %a do %a done|} print_expr expr print_block block
  | Sprint expr -> fprintf fmt {|print %a|} print_expr expr

and print_block fmt = function
  | Bexpr expr -> print_expr fmt expr
  | Bseq (expr, block) ->
    fprintf fmt {|%a; %a|} print_expr expr print_block block

let print_prog fmt expr = fprintf fmt {|@[%a@[@.|} print_expr expr

let str_loc (loc : location) =
  let start, _end = loc in
  let file = start.pos_fname in
  let line = start.pos_lnum in
  let char = start.pos_cnum - start.pos_bol in
  sprintf {|File "%s", line %d, char %d|} file line char

let pp_loc fmt (loc : location) = pp_print_string fmt (str_loc loc)
