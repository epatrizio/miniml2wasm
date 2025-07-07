compiler function array:
  $ dune exec miniml2wasm -- func_array.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/func_array.wasm: done!
  $ wasm -d _wasm/func_array.wasm -o _wasm/func_array.wat
  $ owi _wasm/func_array.wat --debug
  simplifying  ...
  typechecking ...
  function 5function 4function 3function 2function 1function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 5
  calling func : func 5
  stack        : [  ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 20 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 24
  stack        : [ i32.const 24 ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ; i32.const 24 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 28
  stack        : [ i32.const 28 ]
  running instr: i32.const 10
  stack        : [ i32.const 10 ; i32.const 28 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 32
  stack        : [ i32.const 32 ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ; i32.const 32 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 36
  stack        : [ i32.const 36 ]
  running instr: i32.const 30
  stack        : [ i32.const 30 ; i32.const 36 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 40 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 44
  stack        : [ i32.const 44 ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ; i32.const 44 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 48
  stack        : [ i32.const 48 ]
  running instr: i32.const 10
  stack        : [ i32.const 10 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 52
  stack        : [ i32.const 52 ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ; i32.const 52 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 56
  stack        : [ i32.const 56 ]
  running instr: i32.const 30
  stack        : [ i32.const 30 ; i32.const 56 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 40 ]
  stack        : [ i32.const 40 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 40 ]
  running instr: call 4
  calling func : func 4
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 0 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ; i32.const 4 ]
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
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 40 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 40 ]
  running instr: i32.add
  stack        : [ i32.const 44 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: block   <expr>
  stack        : [  ]
  running instr: loop   <expr>
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 0 ]
  running instr: local.get 2
  stack        : [ i32.const 3 ; i32.const 0 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      call 2
      i32.store 
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: local.get 3
  stack        : [ i32.const 0 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 0 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: local.get 0
  stack        : [ i32.const 40 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 40 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 44 ; i32.const 8 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 8 ]
  running instr: local.get 3
  stack        : [ i32.const 0 ; i32.const 3 ; i32.const 8 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 8 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 8 ]
  running instr: nop
  stack        : [ i32.const 8 ]
  stack        : [ i32.const 8 ]
  running instr: local.get 0
  stack        : [ i32.const 40 ; i32.const 8 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 40 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 48 ; i32.const 8 ]
  running instr: local.get 3
  stack        : [ i32.const 0 ; i32.const 48 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 48 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 0 ; i32.const 48 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 48 ; i32.const 8 ]
  running instr: i32.load 
  stack        : [ i32.const 10 ; i32.const 8 ]
  running instr: call 2
  calling func : func 2
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 10 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 10 ]
  running instr: i32.mul
  stack        : [ i32.const 20 ]
  stack        : [ i32.const 20 ; i32.const 8 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 0 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 1 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 1 ]
  running instr: local.get 2
  stack        : [ i32.const 3 ; i32.const 1 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      call 2
      i32.store 
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: local.get 3
  stack        : [ i32.const 1 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 1 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 4 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 12 ]
  running instr: local.get 0
  stack        : [ i32.const 40 ; i32.const 12 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 40 ; i32.const 12 ]
  running instr: i32.add
  stack        : [ i32.const 44 ; i32.const 12 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 12 ]
  running instr: local.get 3
  stack        : [ i32.const 1 ; i32.const 3 ; i32.const 12 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 12 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 12 ]
  running instr: nop
  stack        : [ i32.const 12 ]
  stack        : [ i32.const 12 ]
  running instr: local.get 0
  stack        : [ i32.const 40 ; i32.const 12 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 40 ; i32.const 12 ]
  running instr: i32.add
  stack        : [ i32.const 48 ; i32.const 12 ]
  running instr: local.get 3
  stack        : [ i32.const 1 ; i32.const 48 ; i32.const 12 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 1 ; i32.const 48 ; i32.const 12 ]
  running instr: i32.mul
  stack        : [ i32.const 4 ; i32.const 48 ; i32.const 12 ]
  running instr: i32.add
  stack        : [ i32.const 52 ; i32.const 12 ]
  running instr: i32.load 
  stack        : [ i32.const 20 ; i32.const 12 ]
  running instr: call 2
  calling func : func 2
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 20 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 20 ]
  running instr: i32.mul
  stack        : [ i32.const 40 ]
  stack        : [ i32.const 40 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 1 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 1 ]
  running instr: i32.add
  stack        : [ i32.const 2 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 2 ]
  running instr: local.get 2
  stack        : [ i32.const 3 ; i32.const 2 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      call 2
      i32.store 
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: local.get 3
  stack        : [ i32.const 2 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 2 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 8 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 16 ]
  running instr: local.get 0
  stack        : [ i32.const 40 ; i32.const 16 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 40 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 44 ; i32.const 16 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 16 ]
  running instr: local.get 3
  stack        : [ i32.const 2 ; i32.const 3 ; i32.const 16 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 16 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 16 ]
  running instr: nop
  stack        : [ i32.const 16 ]
  stack        : [ i32.const 16 ]
  running instr: local.get 0
  stack        : [ i32.const 40 ; i32.const 16 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 40 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 48 ; i32.const 16 ]
  running instr: local.get 3
  stack        : [ i32.const 2 ; i32.const 48 ; i32.const 16 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 2 ; i32.const 48 ; i32.const 16 ]
  running instr: i32.mul
  stack        : [ i32.const 8 ; i32.const 48 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 56 ; i32.const 16 ]
  running instr: i32.load 
  stack        : [ i32.const 30 ; i32.const 16 ]
  running instr: call 2
  calling func : func 2
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 30 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 30 ]
  running instr: i32.mul
  stack        : [ i32.const 60 ]
  stack        : [ i32.const 60 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 2 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 2 ]
  running instr: i32.add
  stack        : [ i32.const 3 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 3 ]
  running instr: local.get 2
  stack        : [ i32.const 3 ; i32.const 3 ]
  running instr: i32.lt_s
  stack        : [ i32.const 0 ]
  running instr: (if  
    (then
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      call 2
      i32.store 
      local.get 3
      i32.const 1
      i32.add
      local.set 3
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
  stack        : [ i32.const 0 ]
  stack        : [ i32.const 0 ]
  stack        : [ i32.const 0 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: local.get 2
  stack        : [ i32.const 0 ]
  running instr: call 3
  calling func : func 3
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 0 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 8 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 8 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 3 ; i32.const 8 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 8 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 8 ]
  running instr: nop
  stack        : [ i32.const 8 ]
  stack        : [ i32.const 8 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 8 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 8 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 8 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 8 ]
  running instr: i32.load 
  stack        : [ i32.const 20 ; i32.const 8 ]
  running instr: call 2
  calling func : func 2
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 20 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 20 ]
  running instr: i32.mul
  stack        : [ i32.const 40 ]
  stack        : [ i32.const 40 ; i32.const 8 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 1 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 4 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 12 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 12 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 12 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 12 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 12 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 3 ; i32.const 12 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 12 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 12 ]
  running instr: nop
  stack        : [ i32.const 12 ]
  stack        : [ i32.const 12 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 12 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 12 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 12 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 8 ; i32.const 12 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 1 ; i32.const 8 ; i32.const 12 ]
  running instr: i32.mul
  stack        : [ i32.const 4 ; i32.const 8 ; i32.const 12 ]
  running instr: i32.add
  stack        : [ i32.const 12 ; i32.const 12 ]
  running instr: i32.load 
  stack        : [ i32.const 40 ; i32.const 12 ]
  running instr: call 2
  calling func : func 2
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 40 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 40 ]
  running instr: i32.mul
  stack        : [ i32.const 80 ]
  stack        : [ i32.const 80 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 8 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 2 ; i32.const 8 ]
  running instr: i32.mul
  stack        : [ i32.const 8 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 16 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 16 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 16 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 16 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 3 ; i32.const 16 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 16 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 16 ]
  running instr: nop
  stack        : [ i32.const 16 ]
  stack        : [ i32.const 16 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 16 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 16 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 8 ; i32.const 16 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 2 ; i32.const 8 ; i32.const 16 ]
  running instr: i32.mul
  stack        : [ i32.const 8 ; i32.const 8 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 16 ; i32.const 16 ]
  running instr: i32.load 
  stack        : [ i32.const 60 ; i32.const 16 ]
  running instr: call 2
  calling func : func 2
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 60 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 60 ]
  running instr: i32.mul
  stack        : [ i32.const 120 ]
  stack        : [ i32.const 120 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  stack        : [ i32.const 0 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 0 ]
  running instr: call 1
  calling func : func 1
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: block   <expr>
  stack        : [  ]
  running instr: local.get 1
  stack        : [ i32.const 3 ]
  running instr: i32.const 3
  stack        : [ i32.const 3 ; i32.const 3 ]
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
  running instr: loop   <expr>
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 0 ]
  running instr: local.get 1
  stack        : [ i32.const 3 ; i32.const 0 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 2
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      i32.add
      local.set 2
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 2
  stack        : [ i32.const 0 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 0 ]
  running instr: local.get 3
  stack        : [ i32.const 0 ; i32.const 3 ; i32.const 0 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 0 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 0 ]
  running instr: nop
  stack        : [ i32.const 0 ]
  stack        : [ i32.const 0 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 0 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: local.get 3
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 8 ; i32.const 0 ]
  running instr: i32.mul
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 0 ]
  running instr: i32.load 
  stack        : [ i32.const 40 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 40 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 0 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 1 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 1 ]
  running instr: local.get 1
  stack        : [ i32.const 3 ; i32.const 1 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 2
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      i32.add
      local.set 2
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 2
  stack        : [ i32.const 40 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 40 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 40 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 40 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 40 ]
  running instr: local.get 3
  stack        : [ i32.const 1 ; i32.const 3 ; i32.const 40 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 40 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 40 ]
  running instr: nop
  stack        : [ i32.const 40 ]
  stack        : [ i32.const 40 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 40 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 40 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 40 ]
  running instr: local.get 3
  stack        : [ i32.const 1 ; i32.const 8 ; i32.const 40 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 1 ; i32.const 8 ; i32.const 40 ]
  running instr: i32.mul
  stack        : [ i32.const 4 ; i32.const 8 ; i32.const 40 ]
  running instr: i32.add
  stack        : [ i32.const 12 ; i32.const 40 ]
  running instr: i32.load 
  stack        : [ i32.const 80 ; i32.const 40 ]
  running instr: i32.add
  stack        : [ i32.const 120 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 1 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 1 ]
  running instr: i32.add
  stack        : [ i32.const 2 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 2 ]
  running instr: local.get 1
  stack        : [ i32.const 3 ; i32.const 2 ]
  running instr: i32.lt_s
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 2
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      i32.add
      local.set 2
      local.get 3
      i32.const 1
      i32.add
      local.set 3
      br 1
    )
    (else
      nop
    )
  )
  stack        : [  ]
  running instr: local.get 2
  stack        : [ i32.const 120 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 120 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 120 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 120 ]
  running instr: i32.load 
  stack        : [ i32.const 3 ; i32.const 120 ]
  running instr: local.get 3
  stack        : [ i32.const 2 ; i32.const 3 ; i32.const 120 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 120 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 120 ]
  running instr: nop
  stack        : [ i32.const 120 ]
  stack        : [ i32.const 120 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 120 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 120 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 120 ]
  running instr: local.get 3
  stack        : [ i32.const 2 ; i32.const 8 ; i32.const 120 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 2 ; i32.const 8 ; i32.const 120 ]
  running instr: i32.mul
  stack        : [ i32.const 8 ; i32.const 8 ; i32.const 120 ]
  running instr: i32.add
  stack        : [ i32.const 16 ; i32.const 120 ]
  running instr: i32.load 
  stack        : [ i32.const 120 ; i32.const 120 ]
  running instr: i32.add
  stack        : [ i32.const 240 ]
  running instr: local.set 2
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 2 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 2 ]
  running instr: i32.add
  stack        : [ i32.const 3 ]
  running instr: local.set 3
  stack        : [  ]
  running instr: br 1
  stack        : [  ]
  running instr: local.get 3
  stack        : [ i32.const 3 ]
  running instr: local.get 1
  stack        : [ i32.const 3 ; i32.const 3 ]
  running instr: i32.lt_s
  stack        : [ i32.const 0 ]
  running instr: (if  
    (then
      local.get 2
      local.get 0
      i32.const 4
      i32.add
      i32.load 
      local.get 3
      i32.gt_s
      (if  
        (then
          nop
        )
        (else
          unreachable
        )
      )
      local.get 0
      i32.const 8
      i32.add
      local.get 3
      i32.const 4
      i32.mul
      i32.add
      i32.load 
      i32.add
      local.set 2
      local.get 3
      i32.const 1
      i32.add
      local.set 3
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
  running instr: local.get 2
  stack        : [ i32.const 240 ]
  stack        : [ i32.const 240 ]
  stack        : [ i32.const 240 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
