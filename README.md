# miniml2wasm - MiniML to WebAssembly compiler written in OCaml

<!-- $MDX file=test/42.mml -->
```ml
(* type is optional, it can be inferred *)
(* let x = 42 in *)
let x : i32 = 42 in
  print x
```
