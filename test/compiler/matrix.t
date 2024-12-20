compiler:
  $ dune exec miniml2wasm -- matrix.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/matrix.wasm: done!
  $ wasm -d _wasm/matrix.wasm -o _wasm/matrix.wat
  $ owi _wasm/matrix.wat --debug
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
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 0 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ; i32.const 8 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ; i32.const 20 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 24
  stack        : [ i32.const 24 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 24 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 28
  stack        : [ i32.const 28 ]
  running instr: i32.const 11
  stack        : [ i32.const 11 ; i32.const 28 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 32
  stack        : [ i32.const 32 ]
  running instr: i32.const 111
  stack        : [ i32.const 111 ; i32.const 32 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ]
  running instr: i32.const 12
  stack        : [ i32.const 12 ; i32.const 16 ]
  running instr: i32.const 36
  stack        : [ i32.const 36 ; i32.const 12 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [ i32.const 16 ]
  running instr: i32.const 36
  stack        : [ i32.const 36 ; i32.const 16 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [ i32.const 16 ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ; i32.const 16 ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ; i32.const 40 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [ i32.const 16 ]
  running instr: i32.const 44
  stack        : [ i32.const 44 ; i32.const 16 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 44 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [ i32.const 16 ]
  running instr: i32.const 48
  stack        : [ i32.const 48 ; i32.const 16 ]
  running instr: i32.const 22
  stack        : [ i32.const 22 ; i32.const 48 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [ i32.const 16 ]
  running instr: i32.const 52
  stack        : [ i32.const 52 ; i32.const 16 ]
  running instr: i32.const 222
  stack        : [ i32.const 222 ; i32.const 52 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [ i32.const 16 ]
  running instr: i32.const 36
  stack        : [ i32.const 36 ; i32.const 16 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 36 ; i32.const 16 ]
  running instr: local.set 0
  stack        : [ i32.const 36 ; i32.const 16 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 8 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 1 ; i32.const 8 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.mul
  stack        : [ i32.const 4 ; i32.const 8 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 12 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.load 
  stack        : [ i32.const 36 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 36 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 44 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 44 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 2 ; i32.const 44 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.mul
  stack        : [ i32.const 8 ; i32.const 44 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 52 ; i32.const 36 ; i32.const 16 ]
  running instr: i32.load 
  stack        : [ i32.const 222 ; i32.const 36 ; i32.const 16 ]
  running instr: drop
  stack        : [ i32.const 36 ; i32.const 16 ]
  running instr: drop
  stack        : [ i32.const 16 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
