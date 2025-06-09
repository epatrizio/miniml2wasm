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
  $ dune exec miniml2wasm -- list_hd.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/list_hd.wasm: done!
  $ wasm -d _wasm/list_hd.wasm -o _wasm/list_hd.wat
  $ owi _wasm/list_hd.wat --debug
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
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ; i32.const 0 ]
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
  running instr: local.set 1
  stack        : [  ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ]
  running instr: i32.const 42
  stack        : [ i32.const 42 ; i32.const 8 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 12
  stack        : [ i32.const 12 ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ; i32.const 12 ]
  running instr: i32.const 41
  stack        : [ i32.const 41 ; i32.const 16 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [ i32.const 12 ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ; i32.const 12 ]
  running instr: local.get 1
  stack        : [ i32.const 0 ; i32.const 20 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [ i32.const 12 ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: local.get 2
  stack        : [ i32.const 8 ]
  running instr: i32.load 
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
  $ dune exec miniml2wasm -- list_tl.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/list_tl.wasm: done!
  $ wasm -d _wasm/list_tl.wasm -o _wasm/list_tl.wat
  $ owi _wasm/list_tl.wat --debug
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
  running instr: i32.const 41
  stack        : [ i32.const 41 ; i32.const 0 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 4 ]
  running instr: i32.const 42
  stack        : [ i32.const 42 ; i32.const 8 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [ i32.const 4 ]
  running instr: i32.const 12
  stack        : [ i32.const 12 ; i32.const 4 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 12 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [ i32.const 4 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 8 ]
  running instr: i32.load 
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
