factorial:
  $ dune exec miniml2wasm -- fact.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/fact.wasm: done!
  $ wasm -d _wasm/fact.wasm -o _wasm/fact.wat
  $ owi _wasm/fact.wat --debug
  simplifying  ...
  typechecking ...
  function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 6
  stack        : [ i32.const 6 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: block   <expr>
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 6 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: loop   <expr>
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 6 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 6 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.sub
      local.set 0
      local.get 1
      local.get 0
      i32.mul
      local.set 1
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 6 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 6 ]
  running instr: i32.sub
  stack        : [ i32.const 5 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 6 ]
  running instr: local.get 0
  stack        : [ i32.const 5 ; i32.const 6 ]
  running instr: i32.mul
  stack        : [ i32.const 30 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 5 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 5 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.sub
      local.set 0
      local.get 1
      local.get 0
      i32.mul
      local.set 1
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 5 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 5 ]
  running instr: i32.sub
  stack        : [ i32.const 4 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 30 ]
  running instr: local.get 0
  stack        : [ i32.const 4 ; i32.const 30 ]
  running instr: i32.mul
  stack        : [ i32.const 120 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 4 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 4 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.sub
      local.set 0
      local.get 1
      local.get 0
      i32.mul
      local.set 1
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 4 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 4 ]
  running instr: i32.sub
  stack        : [ i32.const 3 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 120 ]
  running instr: local.get 0
  stack        : [ i32.const 3 ; i32.const 120 ]
  running instr: i32.mul
  stack        : [ i32.const 360 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 3 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 3 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.sub
      local.set 0
      local.get 1
      local.get 0
      i32.mul
      local.set 1
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 3 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 3 ]
  running instr: i32.sub
  stack        : [ i32.const 2 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 360 ]
  running instr: local.get 0
  stack        : [ i32.const 2 ; i32.const 360 ]
  running instr: i32.mul
  stack        : [ i32.const 720 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 2 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 2 ]
  running instr: i32.gt_s
  stack        : [ i32.const 0 ]
  running instr: (if  
    (then
      local.get 0
      i32.const 1
      i32.sub
      local.set 0
      local.get 1
      local.get 0
      i32.mul
      local.set 1
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
  running instr: local.get 1
  stack        : [ i32.const 720 ]
  stack        : [ i32.const 720 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
