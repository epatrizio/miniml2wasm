compiler:
  $ dune exec miniml2wasm -- compiler_1.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/compiler_1.wasm: done!
  $ wasm -d _wasm/compiler_1.wasm -o _wasm/compiler_1.wat
  $ owi _wasm/compiler_1.wat --debug
  simplifying  ...
  typechecking ...
  function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      i32.const -1
      global.get 0
      local.get 0
      i32.add
      i32.mul
    )
    (else
      global.get 0
      local.get 0
      i32.add
    )
  )
  stack        : [  ]
  running instr: i32.const -1
  stack        : [ i32.const -1 ]
  running instr: global.get 0
  stack        : [ i32.const 40 ; i32.const -1 ]
  running instr: local.get 0
  stack        : [ i32.const 2 ; i32.const 40 ; i32.const -1 ]
  running instr: i32.add
  stack        : [ i32.const 42 ; i32.const -1 ]
  running instr: i32.mul
  stack        : [ i32.const -42 ]
  stack        : [ i32.const -42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
