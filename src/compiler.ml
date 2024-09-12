(* WebAssembly (Wasm) compiler *)

(* open Ast *)
open Syntax

let compile_expr _expr env = Ok ("", env)

let compile prog env =
  let magic = "\x00\x61\x73\x6D" in
  let version = "\x01\x00\x00\x00" in
  let* wasm, env = compile_expr prog env in
  let wasm_bytes = Format.sprintf {|%s%s%s|} magic version wasm in
  Ok (wasm_bytes, env)
