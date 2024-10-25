compiler:
  $ dune exec miniml2wasm -- while.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/while.wasm: done!
  $ wasm -d _wasm/while.wasm -o _wasm/while.wat
  $ owi _wasm/while.wat --debug
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
  running instr: block   <expr>
  stack        : [  ]
  running instr: loop   <expr>
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 0 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.add
      local.set 0
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 1 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 1 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 1 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.add
      local.set 0
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 1 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 1 ]
  running instr: i32.add
  stack        : [ i32.const 2 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 2 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 2 ]
  running instr: i32.lt_s
  stack        : [ i32.const 0 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.add
      local.set 0
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: nop
  stack        : [  ]
  stack        : [  ]
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 2 ]
  stack        : [ i32.const 2 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
