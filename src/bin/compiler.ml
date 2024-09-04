open Format
open Miniml2wasm
open Syntax

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
    let prog = parser lexer in
    if debug then begin
      print_endline "debug mode";
      Ast.print_prog Format.std_formatter prog
    end;
    print_endline "typing ...";
    let* _prog = Typer.typecheck_prog prog in
    close_in ic;
    Ok ()
  with
  | Lexer.Lexing_error message -> Error ("Lexing error: " ^ message)
  | Parser.Error ->
    let loc = Sedlexing.lexing_positions lexbuf in
    Error ("Syntax error: " ^ Ast.str_loc loc)
  | Typer.Typing_error message -> Error ("Typing error: " ^ message)

(* Compiler entry point *)
let () =
  Arg.parse options set_file usage;
  match process !in_file_name !debug with
  | Ok () -> ()
  | Error message -> eprintf "%s@." message
