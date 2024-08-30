let debug = ref false

let in_file_name = ref ""

let set_file s = in_file_name := s

let options = [ ("--debug", Arg.Set debug, " Debug mode") ]

let usage = "usage: dune exec miniml2wasm -- file_name.ml [options]"

let process _source_code_file _debug = print_endline "hello, miniml2wasm!"

(* Entry point *)
let () =
  Arg.parse options set_file usage;
  process !in_file_name !debug
