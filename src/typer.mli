exception Typing_error of string

val typecheck_prog :
     Ast.block
  -> (Ast.typ, 'a) Env.t
  -> (Ast.block * (Ast.typ, 'a) Env.t, string) result
