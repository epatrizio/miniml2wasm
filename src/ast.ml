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

type stmt = location * typ * stmt'

and stmt' =
  | Sassign of ident * expr * stmt
  | Sblock of block
  | Sif of expr * stmt * stmt
  | Swhile of expr * block
  | Sprint of expr

and block =
  | Bstmt of stmt
  | Bseq of stmt * block

type prog = stmt

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

let rec print_stmt fmt (_, _, stmt) =
  match stmt with
  | Sassign (ident, expr, stmt) ->
    fprintf fmt {|let %a = %a in@.@[<v 2>%a@]|}
      (print_ident ~typ_display:true)
      ident print_expr expr print_stmt stmt
  | Sblock block -> print_block fmt block
  | Sif (expr, s1, s2) ->
    fprintf fmt {|if %a then %a else %a|} print_expr expr print_stmt s1
      print_stmt s2
  | Swhile (expr, block) ->
    fprintf fmt {|while %a do %a done|} print_expr expr print_block block
  | Sprint expr -> fprintf fmt {|print %a|} print_expr expr

and print_block fmt = function
  | Bstmt stmt -> print_stmt fmt stmt
  | Bseq (stmt, block) ->
    fprintf fmt {|%a; %a|} print_stmt stmt print_block block

let print_prog fmt prog = fprintf fmt {|@[%a@[@.|} print_stmt prog

let str_loc (loc : location) =
  let start, _end = loc in
  let file = start.pos_fname in
  let line = start.pos_lnum in
  let char = start.pos_cnum - start.pos_bol in
  sprintf {|File "%s", line %d, char %d|} file line char

let pp_loc fmt (loc : location) = pp_print_string fmt (str_loc loc)
