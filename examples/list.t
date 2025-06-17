list stuffs js:
  $ dune exec miniml2wasm -- list.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/list.wasm: done!
  $ deno run --allow-read list.js
  Some stuffs on lists!
  4
  33
  11
  22
  33
  44
