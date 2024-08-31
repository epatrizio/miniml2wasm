(* Abstract Syntax Tree *)

type location = Lexing.position * Lexing.position

type typ =
  | Tunit
  | Tbool
  | Tint32
  | Tunknown

type ident = (*typ **) string

type unop = Unot

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
  | Cint32 of Int32.t

type expr = location * typ * expr'

and expr' =
  | Ecst of cst
  | Eident of ident
  | Eunop of unop * expr
  | Ebinop of binop * expr * expr

type stmt = location * stmt'

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

let pp_loc fmt (loc : location) =
  let start, _end = loc in
  let file = start.pos_fname in
  let line = start.pos_lnum in
  let char = start.pos_cnum - start.pos_bol in
  Format.fprintf fmt {|File "%s", line %d, char %d|} file line char
