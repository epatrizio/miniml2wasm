typing error:
  $ dune exec miniml2wasm -- typer_1.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_1.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- typer_2.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_2.mml", line 1, char 14: attempt to perform an arithmetic binop '+' on a non i32 types
  $ dune exec miniml2wasm -- typer_3.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_3.mml", line 1, char 15: attempt to perform unop '-' on a non i32 type
  $ dune exec miniml2wasm -- typer_4.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_4.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- typer_5.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_5.mml", line 5, char 3: unit type expected in the left-hand side of a sequence
  $ dune exec miniml2wasm -- typer_6.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_6.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- typer_7.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_7.mml", line 3, char 2: type bool is expected in the condition of a while-loop
  $ dune exec miniml2wasm -- typer_8.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_8.mml", line 3, char 2: type unit is expected in the body of a while-loop
  $ dune exec miniml2wasm -- typer_9.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_9.mml", line 3, char 8: attempt to perform an arithmetic binop '-' on a non i32 types
  $ dune exec miniml2wasm -- typer_10.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_10.mml", line 4, char 0: unit type expected in the left-hand side of a sequence
  $ dune exec miniml2wasm -- typer_11.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_11.mml", line 3, char 8: attempt to perform an arithmetic binop '*' on a non i32 types
  $ dune exec miniml2wasm -- typer_12.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_12.mml", line 2, char 2: attempt to dereference a non reference type
  $ dune exec miniml2wasm -- typer_13.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_13.mml", line 2, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- typer_14.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_14.mml", line 3, char 3: attempt to perform an arithmetic binop '+' on a non i32 types
  $ dune exec miniml2wasm -- typer_15.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_15.mml", line 2, char 2: attempt to perform a ref assignment with different types
  $ dune exec miniml2wasm -- typer_16.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_16.mml", line 1, char 0: attempt to perform a boolean binop '&&' on a non boolean types
  $ dune exec miniml2wasm -- typer_17.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "typer_17.mml", line 1, char 0: attempt to perform a comparaison binop '>=' on a non i32 types
