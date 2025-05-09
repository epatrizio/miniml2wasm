compiler array_make:
  $ dune exec miniml2wasm -- array_make.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/array_make.wasm: done!
  $ wasm -d _wasm/array_make.wasm -o _wasm/array_make.wat
  $ owi _wasm/array_make.wat --debug
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
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ; i32.const 8 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 40 ; i32.const 8 ]
  running instr: i32.add
  stack        : [ i32.const 42 ; i32.const 8 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 12
  stack        : [ i32.const 12 ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ; i32.const 12 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 40 ; i32.const 12 ]
  running instr: i32.add
  stack        : [ i32.const 42 ; i32.const 12 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ; i32.const 16 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 40 ; i32.const 16 ]
  running instr: i32.add
  stack        : [ i32.const 42 ; i32.const 16 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ; i32.const 20 ]
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 40 ; i32.const 20 ]
  running instr: i32.add
  stack        : [ i32.const 42 ; i32.const 20 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: i32.const 24
  stack        : [ i32.const 24 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 24 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 28
  stack        : [ i32.const 28 ]
  running instr: i32.const 6
  stack        : [ i32.const 6 ; i32.const 28 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 32
  stack        : [ i32.const 32 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 32 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 1 ; i32.const 32 ]
  running instr: i32.or
  stack        : [ i32.const 1 ; i32.const 32 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 36
  stack        : [ i32.const 36 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 36 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 1 ; i32.const 36 ]
  running instr: i32.or
  stack        : [ i32.const 1 ; i32.const 36 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 40 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 1 ; i32.const 40 ]
  running instr: i32.or
  stack        : [ i32.const 1 ; i32.const 40 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 44
  stack        : [ i32.const 44 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 44 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 1 ; i32.const 44 ]
  running instr: i32.or
  stack        : [ i32.const 1 ; i32.const 44 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 48
  stack        : [ i32.const 48 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 1 ; i32.const 48 ]
  running instr: i32.or
  stack        : [ i32.const 1 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 52
  stack        : [ i32.const 52 ]
  running instr: i32.const 1
  stack        : [ i32.const 1 ; i32.const 52 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 1 ; i32.const 52 ]
  running instr: i32.or
  stack        : [ i32.const 1 ; i32.const 52 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 24
  stack        : [ i32.const 24 ]
  running instr: local.set 1
  stack        : [  ]
  running instr: block   <expr>
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
  running instr: i32.const 32
  stack        : [ i32.const 32 ; i32.const 8 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 4 ]
  running instr: local.get 1
  stack        : [ i32.const 24 ; i32.const 4 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 24 ; i32.const 4 ]
  running instr: i32.add
  stack        : [ i32.const 28 ; i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 6 ; i32.const 4 ]
  running instr: i32.add
  stack        : [ i32.const 10 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 10 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 10 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 10 ]
  running instr: i32.load 
  stack        : [ i32.const 4 ; i32.const 10 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 4 ; i32.const 10 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 10 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 10 ]
  running instr: nop
  stack        : [ i32.const 10 ]
  stack        : [ i32.const 10 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 10 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 10 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 10 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 10 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 8 ; i32.const 10 ]
  running instr: i32.mul
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 10 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 10 ]
  running instr: i32.load 
  stack        : [ i32.const 32 ; i32.const 10 ]
  running instr: i32.add
  stack        : [ i32.const 42 ]
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
