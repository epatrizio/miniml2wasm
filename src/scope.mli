val analysis :
  Ast.block -> ('a, 'b) Env.t -> (Ast.block * ('a, 'b) Env.t, string) result
