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
  function 1function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 42
  stack        : [ i32.const 42 ]
  running instr: call 1
  calling func : func 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 42 ]
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
