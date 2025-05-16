compiler array_make memory:
  $ dune exec miniml2wasm -- array_make_memory.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/array_make_memory.wasm: done!
  $ wasm -d _wasm/array_make_memory.wasm -o _wasm/array_make_memory.wat
  $ owi _wasm/array_make_memory.wat --debug
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
  running instr: i32.const 50
  stack        : [ i32.const 50 ; i32.const 4 ]
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
  running instr: i32.const 20
  stack        : [ i32.const 20 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 20 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 24
  stack        : [ i32.const 24 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 24 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 28
  stack        : [ i32.const 28 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 28 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 32
  stack        : [ i32.const 32 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 32 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 36
  stack        : [ i32.const 36 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 36 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 40 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 44
  stack        : [ i32.const 44 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 44 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 48
  stack        : [ i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 52
  stack        : [ i32.const 52 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 52 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 56
  stack        : [ i32.const 56 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 56 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 60
  stack        : [ i32.const 60 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 60 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 64
  stack        : [ i32.const 64 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 64 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 68
  stack        : [ i32.const 68 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 68 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 72
  stack        : [ i32.const 72 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 72 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 76
  stack        : [ i32.const 76 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 76 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 80
  stack        : [ i32.const 80 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 80 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 84
  stack        : [ i32.const 84 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 84 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 88
  stack        : [ i32.const 88 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 88 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 92
  stack        : [ i32.const 92 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 92 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 96
  stack        : [ i32.const 96 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 96 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 100
  stack        : [ i32.const 100 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 100 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 104
  stack        : [ i32.const 104 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 104 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 108
  stack        : [ i32.const 108 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 108 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 112
  stack        : [ i32.const 112 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 112 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 116
  stack        : [ i32.const 116 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 116 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 120
  stack        : [ i32.const 120 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 120 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 124
  stack        : [ i32.const 124 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 124 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 128
  stack        : [ i32.const 128 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 128 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 132
  stack        : [ i32.const 132 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 132 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 136
  stack        : [ i32.const 136 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 136 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 140
  stack        : [ i32.const 140 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 140 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 144
  stack        : [ i32.const 144 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 144 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 148
  stack        : [ i32.const 148 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 148 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 152
  stack        : [ i32.const 152 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 152 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 156
  stack        : [ i32.const 156 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 156 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 160
  stack        : [ i32.const 160 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 160 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 164
  stack        : [ i32.const 164 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 164 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 168
  stack        : [ i32.const 168 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 168 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 172
  stack        : [ i32.const 172 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 172 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 176
  stack        : [ i32.const 176 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 176 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 180
  stack        : [ i32.const 180 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 180 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 184
  stack        : [ i32.const 184 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 184 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 188
  stack        : [ i32.const 188 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 188 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 192
  stack        : [ i32.const 192 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 192 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 196
  stack        : [ i32.const 196 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 196 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 200
  stack        : [ i32.const 200 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 200 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 204
  stack        : [ i32.const 204 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 204 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ]
  running instr: local.set 0
  stack        : [  ]
  running instr: local.get 0
  stack        : [ i32.const 0 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ]
  running instr: i32.add
  stack        : [ i32.const 4 ]
  running instr: i32.load 
  stack        : [ i32.const 50 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
