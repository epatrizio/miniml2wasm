(* Lexical analyzer *)

open Parser

exception Lexing_error of string

let error message = raise (Lexing_error message)

let digit = [%sedlex.regexp? '0' .. '9']

let letter = [%sedlex.regexp? 'a' .. 'z' | 'A' .. 'Z']

let name = [%sedlex.regexp? Plus (letter | digit | '_')]

let blank = [%sedlex.regexp? ' ' | '\t']

let newline = [%sedlex.regexp? '\r' | '\n' | "\r\n"]

let unit = [%sedlex.regexp? "()"]

let boolean = [%sedlex.regexp? "true" | "false"]

let integer = [%sedlex.regexp? Plus digit]

let rec token buf =
  match%sedlex buf with
  | Plus (Chars " \t") -> token buf
  | newline -> token buf
  | unit -> CST Cunit
  | boolean -> CST (Cbool (bool_of_string (Sedlexing.Utf8.lexeme buf)))
  | integer ->
    CST (Ci32 (Int32.of_int (int_of_string (Sedlexing.Utf8.lexeme buf))))
  | '+' -> PLUS
  | '-' -> MINUS
  | '*' -> MUL
  | '/' -> DIV
  | "==" -> EQEQ
  | "!=" -> NEQ
  | '<' -> LT
  | "<=" -> LE
  | '>' -> GT
  | ">=" -> GE
  | '=' -> EQ
  | ":=" -> REFEQ
  | '(' -> LPAREN
  | ')' -> RPAREN
  | '[' -> LBRACKET
  | ']' -> RBRACKET
  | ',' -> COMMA
  | ';' -> SEMICOLON
  | ':' -> COLON
  | '!' -> EXCL
  | "let" -> LET
  | "in" -> IN
  | "begin" -> BEGIN
  | "end" -> END
  | "if" -> IF
  | "then" -> THEN
  | "else" -> ELSE
  | "while" -> WHILE
  | "do" -> DO
  | "done" -> DONE
  | "ref" -> REF
  | "&&" -> AND
  | "||" -> OR
  | "not" -> NOT
  | "array_size" -> ARRAY_SIZE
  | "assert" -> ASSERT
  | "print_i32" -> PRINT_I32
  | "read_i32" -> READ_I32
  | "unit" -> TUNIT
  | "bool" -> TBOOL
  | "i32" -> TI32
  | "(*" -> comment buf
  | name -> NAME (Sedlexing.Utf8.lexeme buf)
  | eof -> EOF
  | _ ->
    let lxm = Sedlexing.Utf8.lexeme buf in
    let pos = Sedlexing.lexing_positions buf in
    Format.kasprintf error "%a: unexpected lexeme %S" Ast.pp_loc pos lxm

and comment buf =
  match%sedlex buf with
  | newline | eof | "*)" -> token buf
  | any -> comment buf
  | _ ->
    let lxm = Sedlexing.Utf8.lexeme buf in
    let pos = Sedlexing.lexing_positions buf in
    Format.kasprintf error "%a: unexpected lexeme %S" Ast.pp_loc pos lxm
