(* Bump allocator: Linear memory - 1 page = 65,536 bytes *)

open Ast

type t =
  { previous_pointer : Int32.t
  ; pointer : Int32.t
  ; pages : Int32.t
  }

let malloc size mem =
  let nb_pages pt =
    let pages = Int32.div pt 65536l in
    let pages = Int32.succ pages in
    pages
  in
  let previous_pointer = mem.pointer in
  let pointer = Int32.add mem.pointer size in
  let pages = nb_pages pointer in
  { previous_pointer; pointer; pages }

(* Array representation: type[array_size]
     1. type: an i32 id  - meta data
     2. array_size: i32  - meta data
     3. array content length: array_size*type_len (i32)
   Memo: byte ref (Ex. i32 = "4" * 8)

   Restriction: 2-dim array max, i32 data
   2-dim array compilation schema: data = subarray pointer
    (check Compiler_basic.get_type_id_for_array)
*)
let malloc_array typ mem =
  let malloc_size typ =
    match typ with
    | Tarray (Ti32, size)
    | Tarray (Tbool, size)
    | Tarray (Tarray (Ti32, _), size)
    | Tarray (Tarray (Tbool, _), size) ->
      (* 1. *)
      let msize = 4l in
      (* 2. *)
      let msize = Int32.add msize 4l in
      (* 3. *)
      let msize = Int32.add msize (Int32.mul 4l size) in
      msize
    | _ -> assert false
  in
  let size = malloc_size typ in
  let mem = malloc size mem in
  mem

(* List representation
    1. cell value (type_len:i32)
    2. next pointer (i32)
  Restriction: only bool & i32 list
*)
let malloc_list_cell typ mem =
  let malloc_size typ =
    match typ with
    | Tlist Ti32 | Tlist Tbool ->
      (* 1. *)
      let msize = 4l in
      (* 2. *)
      let msize = Int32.add msize 4l in
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
  let pages = 0l in
  { previous_pointer; pointer; pages }
