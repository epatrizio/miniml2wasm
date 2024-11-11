(* WebAssembly (Wasm) compiler : basic stuff *)

(* source of some basic encoding functions :
   https://github.com/OCamlPro/owi/blob/main/src/ast/binary_encoder.ml
   owi (developed by my friends at OCamlPro): A WebAssembly Swissknife & cross-language bugfinder *)

open Ast

type blocktype =
  | Empty
  | Valtyp of typ
  | S33 of int64

type var_access =
  | Get
  | Set

type limits =
  | Limit_without_max of Int32.t
  | Limit_with_max of Int32.t * Int32.t

exception Compiling_error of string

let error loc message =
  let message = Format.sprintf {|%s: %s|} (str_loc loc) message in
  raise (Compiling_error message)

let get_local_idx loc name env =
  match Env.get_local_wasm_idx name env with
  | Some idx -> idx
  | None -> error loc "local not exists!"

let get_var_idx buf var_access loc name env =
  let local_action buf = function
    | Get -> Buffer.add_char buf '\x20'
    | Set -> Buffer.add_char buf '\x21'
  in
  let global_action buf = function
    | Get -> Buffer.add_char buf '\x23'
    | Set -> Buffer.add_char buf '\x24'
  in
  match Env.get_local_wasm_idx name env with
  | Some idx ->
    local_action buf var_access;
    idx
  | None -> (
    match Env.get_global_wasm_idx name env with
    | Some idx ->
      global_action buf var_access;
      idx
    | None -> error loc "var not exists!" )

let get_blocktype = function
  | Tunit -> Empty
  | Tbool -> Valtyp Tbool
  | Ti32 -> Valtyp Ti32
  | Tarray _ -> assert false
  | Tref _ -> assert false
  | Tunknown -> assert false

(* add byte from int (ascii code) *)
let write_byte buf i =
  let c = Char.chr (i land 0xff) in
  Buffer.add_char buf c

let rec write_u64 buf i =
  let b = Int64.to_int (Int64.logand i 0x7fL) in
  if Int64.compare 0L i <= 0 && Int64.compare i 128L < 0 then write_byte buf b
  else begin
    write_byte buf (b lor 0x80);
    write_u64 buf (Int64.shift_right_logical i 7)
  end

let write_u32 buf i =
  write_u64 buf (Int64.logand (Int64.of_int32 i) 0xffffffffL)

let write_u32_of_int buf i =
  let i = Int32.of_int i in
  write_u32 buf i

let rec write_s64 buf i =
  let b = Int64.to_int (Int64.logand i 0x7fL) in
  if Int64.compare (-64L) i <= 0 && Int64.compare i 64L < 0 then
    write_byte buf b
  else begin
    write_byte buf (b lor 0x80);
    write_s64 buf (Int64.shift_right i 7)
  end

let write_s32 buf i = write_s64 buf (Int64.of_int32 i)

let write_s32_of_int buf i =
  let i = Int32.of_int i in
  write_s32 buf i

let write_i32_const_u buf i =
  Buffer.add_char buf '\x41';
  write_u32 buf i

let write_i32_const_s buf i =
  Buffer.add_char buf '\x41';
  write_s32 buf i

let write_bytes buf il =
  let vector_buf = Buffer.create 16 in
  let len = List.length il in
  List.iter (fun i -> write_byte vector_buf i) il;
  write_u32_of_int buf len;
  Buffer.add_buffer buf vector_buf

let write_unreachable buf = Buffer.add_char buf '\x00'

let write_nop buf = Buffer.add_char buf '\x01'

let write_br buf idx =
  Buffer.add_char buf '\x0c';
  write_u32_of_int buf idx

let write_br_if buf idx =
  Buffer.add_char buf '\x0d';
  write_u32_of_int buf idx

let write_return buf = Buffer.add_char buf '\x0f'

let write_call buf funcidx =
  Buffer.add_char buf '\x10';
  write_u32_of_int buf funcidx

let write_call_indirect buf typeidx tableidx =
  Buffer.add_char buf '\x11';
  write_u32_of_int buf typeidx;
  write_u32_of_int buf tableidx

let write_numtype buf = function
  | Tbool | Ti32 | Tref Ti32 | Tref Tbool | Tarray _ ->
    Buffer.add_char buf '\x7f' (* memory pointer: i32 *)
  | Tunit | Tref _ | Tunknown -> ()

let write_valtype = write_numtype

(* i32.and ... *)
(* Int32: signed intergers > _s operators *)
(* div_s, lt_s, gt_s ... *)
let write_binop buf = function
  | Band -> Buffer.add_char buf '\x71'
  | Bor -> Buffer.add_char buf '\x72'
  | Badd -> Buffer.add_char buf '\x6a'
  | Bsub -> Buffer.add_char buf '\x6b'
  | Bmul -> Buffer.add_char buf '\x6c'
  | Bdiv -> Buffer.add_char buf '\x6d'
  | Beq -> Buffer.add_char buf '\x46'
  | Bneq -> Buffer.add_char buf '\x47'
  | Blt -> Buffer.add_char buf '\x48'
  | Ble -> Buffer.add_char buf '\x4c'
  | Bgt -> Buffer.add_char buf '\x4a'
  | Bge -> Buffer.add_char buf '\x4e'

let write_mut buf = function
  | Tunit | Tbool | Ti32 -> Buffer.add_char buf '\x00'
  | Tref _ -> Buffer.add_char buf '\x01'
  | Tarray _ -> assert false
  | Tunknown -> assert false

let write_blocktype buf = function
  | Empty -> Buffer.add_char buf '\x40'
  | Valtyp typ -> write_valtype buf typ
  | S33 _ -> assert false

let write_globaltype buf typ =
  write_valtype buf typ;
  write_mut buf typ

let write_limits buf limits =
  match limits with
  | Limit_without_max min ->
    Buffer.add_char buf '\x00';
    write_u32 buf min
  | Limit_with_max (min, max) ->
    Buffer.add_char buf '\x01';
    write_u32 buf min;
    write_u32 buf max

let write_memtype = write_limits

let write_memarg buf =
  (* TODO *)
  write_u32 buf 0l;
  write_u32 buf 0l

let write_store buf typ =
  match typ with
  | Ti32 | Tbool ->
    Buffer.add_char buf '\x36';
    write_memarg buf
  | _ -> assert false

let write_load buf typ =
  match typ with
  | Ti32 | Tbool ->
    Buffer.add_char buf '\x28';
    write_memarg buf
  | _ -> assert false
