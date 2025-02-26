compiler function:
  $ dune exec miniml2wasm -- func.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/func.wasm: done!
  $ wasm -d _wasm/func.wasm -o _wasm/func.wat
  $ owi _wasm/func.wat --debug
  simplifying  ...
  typechecking ...
  function 4function 3function 2function 1function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 10
  stack        : [ i32.const 10 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 10 ]
  running instr: local.get 2
  stack        : [ i32.const 4 ; i32.const 10 ]
  running instr: i32.add
  stack        : [ i32.const 14 ]
  running instr: call 4
  calling func : func 4
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 14 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 14 ]
  running instr: i32.div_s
  stack        : [ i32.const 7 ]
  stack        : [ i32.const 7 ]
  running instr: call 2
  calling func : func 2
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 7 ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ; i32.const 7 ]
  running instr: i32.mul
  stack        : [ i32.const 21 ]
  stack        : [ i32.const 21 ]
  running instr: call 1
  calling func : func 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 21 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 21 ]
  running instr: i32.mul
  stack        : [ i32.const 42 ]
  stack        : [ i32.const 42 ]
  running instr: call 3
  calling func : func 3
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 42 ]
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
