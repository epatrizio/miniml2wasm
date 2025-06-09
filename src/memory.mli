type t =
  { previous_pointer : Int32.t
  ; pointer : Int32.t
  ; pages : Int32.t
  }

val malloc_array : Ast.typ -> t -> t

val malloc_list_cell : Ast.typ -> t -> t

val is_empty : t -> bool

val init : unit -> t
