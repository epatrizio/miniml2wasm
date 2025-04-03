type t =
  { previous_pointer : int32
  ; pointer : int32
  }

val malloc_array : Ast.typ -> t -> t

val is_empty : t -> bool

val init : unit -> t
