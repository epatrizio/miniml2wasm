(* Memory: bump allocator *)

open Ast

type t =
  { previous_pointer : Int32.t
  ; pointer : Int32.t
  }

let malloc size mem =
  let previous_pointer = mem.pointer in
  let pointer = Int32.add mem.pointer size in
  { previous_pointer; pointer }

(* Array representation: type[array_size]
     1. type: an i32 id  - meta data
     2. array_size: i32  - meta data
     3. array content length: array_size*type_len (i32)
   Memo: byte ref (Ex. i32 = "4" * 8)
*)
let malloc_array typ mem =
  match typ with
  | Tarray (Ti32, size) | Tarray (Tbool, size) ->
    (* 1. *)
    let malloc_size = 4l in
    (* 2. *)
    let malloc_size = Int32.add malloc_size 4l in
    (* 3. *)
    let malloc_size = Int32.add malloc_size (Int32.mul 4l size) in
    let mem = malloc malloc_size mem in
    mem
  | _ -> assert false

let is_empty mem = mem.pointer = 0l

let init () =
  let previous_pointer = 0l in
  let pointer = 0l in
  { previous_pointer; pointer }
