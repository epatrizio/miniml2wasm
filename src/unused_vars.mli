module SMap : Map.S with type key = string

type variables_use =
  { globals : int SMap.t
  ; locals : int SMap.t
  }

val print_analysis : variables_use -> unit

val analysis : Ast.block -> (variables_use, string) result
