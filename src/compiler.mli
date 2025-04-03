val compile :
     Ast.block
  -> (Ast.typ, Buffer.t) Env.t
  -> (string * (Ast.typ, Buffer.t) Env.t, string) result
