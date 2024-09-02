open Format
open Miniml2wasm

let debug = ref false

let in_file_name = ref ""

let set_file s = in_file_name := s

let options = [ ("--debug", Arg.Set debug, " Debug mode") ]

let usage = "usage: dune exec miniml2wasm -- file_name.ml [options]"

let process source_code_file debug =
  let ic = open_in source_code_file in
  let lexbuf = Sedlexing.Utf8.from_channel ic in
  try
    Sedlexing.set_filename lexbuf source_code_file;
    let lexer = Sedlexing.with_tokenizer Lexer.token lexbuf in
    let parser = MenhirLib.Convert.Simplified.traditional2revised Parser.prog in
    let _prog = parser lexer in
    if debug then begin print_endline "debug mode"
      (* Ast.print_prog Format.std_formatter prog *)
    end;
    close_in ic
  with
  | Lexer.Lexing_error message ->
    eprintf "Lexical error: %s@." message;
    exit 1
  | Parser.Error ->
    let loc = Sedlexing.lexing_positions lexbuf in
    eprintf "Syntax error: %a@." Ast.pp_loc loc;
    exit 1
  | _ -> assert false (* TODO: specific error management *)

(* Entry point *)
let () =
  Arg.parse options set_file usage;
  process !in_file_name !debug
