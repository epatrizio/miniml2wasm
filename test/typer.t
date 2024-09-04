typing error:
  $ dune exec miniml2wasm -- typer_1.mml
  typing ...
  Typing error: File "typer_1.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- typer_2.mml
  typing ...
  Typing error: File "typer_2.mml", line 1, char 14: attempt to perform binop 'add' on a non i32 types
