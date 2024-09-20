# miniml2wasm - MiniML to WebAssembly compiler written in OCaml

<!-- $MDX file=test/42.mml -->
```ml
(* type is optional, it can be inferred *)
let x = 40;           (* global scope *)
let y : i32 = 2 in    (* local scope *)
  print x + y
```
