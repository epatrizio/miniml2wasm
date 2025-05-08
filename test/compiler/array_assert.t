compiler array_assert:
  $ dune exec miniml2wasm -- array_assert.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/array_assert.wasm: done!
  $ wasm -d _wasm/array_assert.wasm -o _wasm/array_assert.wat
  $ owi _wasm/array_assert.wat --debug
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
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 0 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 8 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 12
  stack        : [ i32.const 12 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 16 ]
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
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 24 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: block   <expr>
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 5 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 5 ]
  running instr: i32.eq
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [  ]
  running instr: nop
  stack        : [  ]
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 5 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 5 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [  ]
  running instr: nop
  stack        : [  ]
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 4 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 16 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 24 ]
  running instr: i32.const 42
  stack        : [ i32.const 42 ; i32.const 24 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 5 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 5 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [  ]
  running instr: nop
  stack        : [  ]
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 4 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 16 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 24 ]
  running instr: i32.load 
  stack        : [ i32.const 42 ]
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
