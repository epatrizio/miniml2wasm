compiler assert:
  $ dune exec miniml2wasm -- assert.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/assert.wasm: done!
  $ wasm -d _wasm/assert.wasm -o _wasm/assert.wat
  $ owi _wasm/assert.wat --debug
  simplifying  ...
  typechecking ...
  function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 42
  stack        : [ i32.const 42 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: block   <expr>
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 0 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 0 ]
  running instr: i32.gt_s
  stack        : [ i32.const 0 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [  ]
  running instr: unreachable
  unreachable
  [1]
