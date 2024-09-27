(* WebAssembly (Wasm) compiler *)

(* source of some basic encoding functions :
https://github.com/OCamlPro/owi/blob/main/src/ast/binary_encoder.ml
owi (developed by my friends at OCamlPro): A WebAssembly Swissknife & cross-language bugfinder *)

(* open Ast *)
open Syntax

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

let write_vector buf datas =
  let vector_buf = Buffer.create 16 in
  let len = List.length datas in
  List.iter (Buffer.add_buffer vector_buf) datas;
  write_u32_of_int buf len;
  Buffer.add_buffer buf vector_buf

let write_section buf id content =
  let section_len = Buffer.length content in
  print_int section_len;
  if section_len > 0 then begin
    Buffer.add_char buf id;
    write_u32_of_int buf section_len;
    Buffer.add_buffer buf content
  end

let write_start buf =
  let start_buf = Buffer.create 2 in
  (* hard-coded: start function idx = 0 *)
  write_u32_of_int start_buf 0;
  write_section buf '\x08' start_buf

let write_start_function buf =
  let type_buf = Buffer.create 16 in
  let func_buf = Buffer.create 16 in
  let code_buf = Buffer.create 16 in
  let typeidx_buf = Buffer.create 2 in
  let functype_buf = Buffer.create 16 in
  let body_buf = Buffer.create 16 in
  Buffer.add_char functype_buf '\x60';
  write_vector functype_buf [];
  write_vector functype_buf [];
  write_vector type_buf [ functype_buf ];
  write_section buf '\x01' type_buf;
  write_u32_of_int typeidx_buf 0;
  write_vector func_buf [ typeidx_buf ];
  write_section buf '\x03' func_buf;
  write_start buf;
  write_u32_of_int body_buf 2;
  write_vector body_buf [];
  Buffer.add_char body_buf '\x0b';
  write_vector code_buf [ body_buf ];
  write_section buf '\x0a' code_buf

let compile_expr _expr env = Ok ("", env)

let compile prog env =
  let wasm_buf = Buffer.create 256 in
  (* magic *)
  Buffer.add_string wasm_buf "\x00\x61\x73\x6d";
  (* version *)
  Buffer.add_string wasm_buf "\x01\x00\x00\x00";
  write_start_function wasm_buf;
  let* wasm, env = compile_expr prog env in
  Buffer.add_string wasm_buf wasm;
  let wasm_str = Buffer.contents wasm_buf in
  Ok (wasm_str, env)
