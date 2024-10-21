compiler:
  $ dune exec miniml2wasm -- compiler_2.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/compiler_2.wasm: done!
  $ wasm -d _wasm/compiler_2.wasm -o _wasm/compiler_2.wat
  $ owi _wasm/compiler_2.wat --debug
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
  running instr: i32.const 10
  stack        : [ i32.const 10 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: block   <expr>
  stack        : [  ]
  running instr: i32.const 10
  stack        : [ i32.const 10 ]
  running instr: global.set 0
  stack        : [  ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: global.get 0
  stack        : [ i32.const 10 ]
  running instr: local.get 0
  stack        : [ i32.const 20 ; i32.const 10 ]
  running instr: i32.add
  stack        : [ i32.const 30 ]
  running instr: global.get 1
  stack        : [ i32.const 2 ; i32.const 30 ]
  running instr: i32.add
  stack        : [ i32.const 32 ]
  running instr: local.get 1
  stack        : [ i32.const 10 ; i32.const 32 ]
  running instr: i32.add
  stack        : [ i32.const 42 ]
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
