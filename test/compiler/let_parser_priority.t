compiler:
  $ dune exec miniml2wasm -- let_parser_priority.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/let_parser_priority.wasm: done!
  $ wasm -d _wasm/let_parser_priority.wasm -o _wasm/let_parser_priority.wat
  $ owi _wasm/let_parser_priority.wat --debug
  simplifying  ...
  typechecking ...
  function 0linking      ...
  interpreting ...
  stack        : [  ]
  running instr: call 0
  calling func : func 0
  stack        : [  ]
  running instr: i32.const 21
  stack        : [ i32.const 21 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 21 ]
  running instr: local.get 0
  stack        : [ i32.const 21 ; i32.const 21 ]
  running instr: i32.add
  stack        : [ i32.const 42 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
