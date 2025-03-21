typing error:
  $ dune exec miniml2wasm -- assert.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "assert.mml", line 1, char 0: attempt to perform an assert call on a non boolean value (i32)
  $ dune exec miniml2wasm -- binop_bool.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "binop_bool.mml", line 1, char 0: attempt to perform a boolean binop '&&' on a non boolean types
  $ dune exec miniml2wasm -- binop_ge.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "binop_ge.mml", line 1, char 0: attempt to perform a comparaison binop '>=' on a non i32 types
  $ dune exec miniml2wasm -- binop_min.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "binop_min.mml", line 3, char 3: attempt to perform an arithmetic binop '-' on a non i32 types
  $ dune exec miniml2wasm -- block_1.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "block_1.mml", line 4, char 3: unit type expected in the left-hand side of a sequence
  $ dune exec miniml2wasm -- block_2.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "block_2.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- block_3.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "block_3.mml", line 4, char 0: unit type expected in the left-hand side of a sequence
  $ dune exec miniml2wasm -- fun_1.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_1.mml", line 1, char 14: Inference is not possible in function definition, all arguments must be typed!
  $ dune exec miniml2wasm -- fun_2.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_2.mml", line 1, char 14: function signature (return type) and body type are not uniform. bool expected!
  $ dune exec miniml2wasm -- fun_3.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_3.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- fun_4.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_4.mml", line 2, char 4: function signature and function call are not uniform. 1 argument(s) expected!
  $ dune exec miniml2wasm -- fun_5.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_5.mml", line 3, char 4: attempt to perform a function call on a non function var
  $ dune exec miniml2wasm -- fun_6.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_6.mml", line 2, char 4: attempt to perform a function call with non uniform argument types!
  $ dune exec miniml2wasm -- fun_7.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_7.mml", line 2, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- fun_8.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_8.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- fun_9.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_9.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- fun_10.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "fun_10.mml", line 1, char 0: local scope import functions are not allowed
  $ dune exec miniml2wasm -- global_binop.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "global_binop.mml", line 3, char 3: attempt to perform an arithmetic binop '*' on a non i32 types
  $ dune exec miniml2wasm -- import.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "import.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- local_binop.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "local_binop.mml", line 1, char 14: attempt to perform an arithmetic binop '+' on a non i32 types
  $ dune exec miniml2wasm -- local_if.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "local_if.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- local_unop.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "local_unop.mml", line 1, char 15: attempt to perform unop '-' on a non i32 type
  $ dune exec miniml2wasm -- local.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "local.mml", line 1, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- ref_assign.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "ref_assign.mml", line 2, char 2: attempt to perform a ref assignment with different types
  $ dune exec miniml2wasm -- ref_binop_1.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "ref_binop_1.mml", line 2, char 0: attempt to perform an assignment with different types
  $ dune exec miniml2wasm -- ref_binop_2.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "ref_binop_2.mml", line 3, char 3: attempt to perform an arithmetic binop '+' on a non i32 types
  $ dune exec miniml2wasm -- ref_deref.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "ref_deref.mml", line 2, char 2: attempt to dereference a non reference type
  $ dune exec miniml2wasm -- while_1.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "while_1.mml", line 3, char 2: type bool is expected in the condition of a while-loop
  $ dune exec miniml2wasm -- while_2.mml
  parsing ...
  scope analysing ...
  typechecking ...
  Typechecking error: File "while_2.mml", line 3, char 2: type unit is expected in the body of a while-loop
