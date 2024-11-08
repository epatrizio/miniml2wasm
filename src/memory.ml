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
  let rec malloc_size typ =
    match typ with
    | Tarray (Ti32, size) | Tarray (Tbool, size) ->
      (* 1. *)
      let msize = 4l in
      (* 2. *)
      let msize = Int32.add msize 4l in
      (* 3. *)
      let msize = Int32.add msize (Int32.mul 4l size) in
      msize
    | Tarray (Tarray (typ, subarray_size), size) ->
      (* 1. *)
      let msize = 4l in
      (* 2. *)
      let msize = Int32.add msize 4l in
      (* 3. *)
      let subarray_size = malloc_size (Tarray (typ, subarray_size)) in
      let msize = Int32.add msize (Int32.mul subarray_size size) in
      msize
    | _ -> assert false
  in
  let size = malloc_size typ in
  let mem = malloc size mem in
  mem

let is_empty mem = mem.pointer = 0l

let init () =
  let previous_pointer = 0l in
  let pointer = 0l in
  { previous_pointer; pointer }
