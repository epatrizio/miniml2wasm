open Format
open Miniml2wasm
open Syntax

let debug = ref false

let in_file_name = ref ""

let set_file s = in_file_name := s

let options = [ ("--debug", Arg.Set debug, " Debug mode") ]

let usage = "usage: dune exec miniml2wasm -- file_name.ml [options]"

let wasm_file source_code_file wasm_bytes =
  let source_code_file = Fpath.v source_code_file in
  let target_wasm_file =
    Fpath.add_ext "wasm" (Fpath.rem_ext source_code_file)
  in
  let filename = "wasm/" ^ Fpath.filename target_wasm_file in
  let message = Format.sprintf {|compilation target file %s: done!|} filename in
  let oc = Out_channel.open_bin filename in
  Out_channel.output_string oc wasm_bytes;
  Out_channel.close oc;
  print_endline message

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
      print_endline "raw input program:";
      Ast.print_prog Format.std_formatter prog
    end;
    print_endline "typing ...";
    let* prog = Typer.typecheck_prog prog in
    print_endline "scope analysing ...";
    let env = Env.empty () in
    let* prog, env = Scope.analysis prog env in
    if debug then begin
      print_endline "program after scope analysis:";
      Ast.print_prog Format.std_formatter prog
    end;
    print_endline "compiling ...";
    let* wasm_prog, _env = Compiler.compile prog env in
    wasm_file source_code_file wasm_prog;
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