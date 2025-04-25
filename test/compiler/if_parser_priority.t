compiler:
  $ dune exec miniml2wasm -- if_parser_priority.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/if_parser_priority.wasm: done!
  $ wasm -d _wasm/if_parser_priority.wasm -o _wasm/if_parser_priority.wat
  $ owi _wasm/if_parser_priority.wat --debug
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
  running instr: i32.const 1
  stack        : [ i32.const 1 ]
  running instr: (if  
    (then
      local.get 0
    )
    (else
      local.get 0
      i32.const 2
      i32.mul
    )
  )
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 42 ]
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
