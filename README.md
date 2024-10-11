# miniml2wasm - MiniML to WebAssembly compiler written in OCaml

<!-- $MDX file=test/42.mml -->
```ml
(* type is optional, it can be inferred *)
let x = 40;           (* global scope *)
let y : i32 = 2 in    (* local scope *)
  (x + y)
```

```sh
$ dune exec -- miniml2wasm --help
usage: dune exec miniml2wasm -- file_name.ml [options]
  --debug  Debug mode
  -help  Display this list of options
  --help  Display this list of options
```

```shell-session
$ dune exec miniml2wasm -- test/42.mml
$ wasm -d _wasm/42.wasm -o _wasm/42.wat
$ owi _wasm/42.wat --debug
```
