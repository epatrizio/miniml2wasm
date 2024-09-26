(* WebAssembly (Wasm) compiler *)

(* open Ast *)
open Syntax

let compile_expr _expr env = Ok ("", env)

let compile prog env =
  let wasm_buf = Buffer.create 256 in
  (* magic *)
  Buffer.add_string wasm_buf "\x00\x61\x73\x6d";
  (* version *)
  Buffer.add_string wasm_buf "\x01\x00\x00\x00";
  let* wasm, env = compile_expr prog env in
  Buffer.add_string wasm_buf wasm;
  let wasm_str = Buffer.contents wasm_buf in
  Ok (wasm_str, env)
