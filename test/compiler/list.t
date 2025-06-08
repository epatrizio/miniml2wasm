compiler list:
  $ dune exec miniml2wasm -- list_empty_1.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/list_empty_1.wasm: done!
  $ wasm -d _wasm/list_empty_1.wasm -o _wasm/list_empty_1.wat
  $ owi _wasm/list_empty_1.wat --debug
  simplifying  ...
  typechecking ...
  function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
  $ dune exec miniml2wasm -- list_empty_2.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/list_empty_2.wasm: done!
  $ wasm -d _wasm/list_empty_2.wasm -o _wasm/list_empty_2.wat
  $ owi _wasm/list_empty_2.wat --debug
  simplifying  ...
  typechecking ...
  function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 42
  stack        : [ i32.const 42 ; i32.const 0 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
