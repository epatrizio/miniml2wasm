compiler matrix_make memory:
  $ dune exec miniml2wasm -- matrix_make_memory.mml
  parsing ...
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/matrix_make_memory.wasm: done!
  $ wasm -d _wasm/matrix_make_memory.wasm -o _wasm/matrix_make_memory.wat
  $ owi _wasm/matrix_make_memory.wat --debug
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
  running instr: i32.const 2
  stack        : [ i32.const 2 ; i32.const 0 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ]
  running instr: i32.const 10
  stack        : [ i32.const 10 ; i32.const 4 ]
  running instr: i32.store 
  stack        : [  ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ]
  running instr: i32.const 48
  stack        : [ i32.const 48 ; i32.const 8 ]
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
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 52 ]
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
  running instr: i32.const 48
  stack        : [ i32.const 48 ]
  running instr: i32.const 12
  stack        : [ i32.const 12 ; i32.const 48 ]
  running instr: i32.const 76
  stack        : [ i32.const 76 ; i32.const 12 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 76
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 80
  stack        : [ i32.const 80 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 80 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 84
  stack        : [ i32.const 84 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 84 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 88
  stack        : [ i32.const 88 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 88 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 92
  stack        : [ i32.const 92 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 92 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 96
  stack        : [ i32.const 96 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 96 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 100
  stack        : [ i32.const 100 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 100 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 48 ]
  running instr: i32.const 76
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 16
  stack        : [ i32.const 16 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 104
  stack        : [ i32.const 104 ; i32.const 16 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 104
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 108
  stack        : [ i32.const 108 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 108 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 112
  stack        : [ i32.const 112 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 112 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 116
  stack        : [ i32.const 116 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 116 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 120
  stack        : [ i32.const 120 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 120 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 124
  stack        : [ i32.const 124 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 124 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 128
  stack        : [ i32.const 128 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 128 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: i32.const 104
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 20
  stack        : [ i32.const 20 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 132
  stack        : [ i32.const 132 ; i32.const 20 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 132
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 136
  stack        : [ i32.const 136 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 136 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 140
  stack        : [ i32.const 140 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 140 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 144
  stack        : [ i32.const 144 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 144 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 148
  stack        : [ i32.const 148 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 148 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 152
  stack        : [ i32.const 152 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 152 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 156
  stack        : [ i32.const 156 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 156 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 132
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 24
  stack        : [ i32.const 24 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 160
  stack        : [ i32.const 160 ; i32.const 24 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 160
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 164
  stack        : [ i32.const 164 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 164 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 168
  stack        : [ i32.const 168 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 168 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 172
  stack        : [ i32.const 172 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 172 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 176
  stack        : [ i32.const 176 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 176 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 180
  stack        : [ i32.const 180 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 180 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 184
  stack        : [ i32.const 184 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 184 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 160
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 28
  stack        : [ i32.const 28 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 188
  stack        : [ i32.const 188 ; i32.const 28 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 188
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 192
  stack        : [ i32.const 192 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 192 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 196
  stack        : [ i32.const 196 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 196 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 200
  stack        : [ i32.const 200 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 200 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 204
  stack        : [ i32.const 204 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 204 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 208
  stack        : [ i32.const 208 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 208 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 212
  stack        : [ i32.const 212 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 212 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 188
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 32
  stack        : [ i32.const 32 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 216
  stack        : [ i32.const 216 ; i32.const 32 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 216
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 220
  stack        : [ i32.const 220 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 220 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 224
  stack        : [ i32.const 224 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 224 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 228
  stack        : [ i32.const 228 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 228 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 232
  stack        : [ i32.const 232 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 232 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 236
  stack        : [ i32.const 236 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 236 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 240
  stack        : [ i32.const 240 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 240 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 216
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 36
  stack        : [ i32.const 36 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 244
  stack        : [ i32.const 244 ; i32.const 36 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 244
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 248
  stack        : [ i32.const 248 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 248 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 252
  stack        : [ i32.const 252 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 252 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 256
  stack        : [ i32.const 256 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 256 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 260
  stack        : [ i32.const 260 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 260 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 264
  stack        : [ i32.const 264 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 264 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 268
  stack        : [ i32.const 268 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 268 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 244
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 40
  stack        : [ i32.const 40 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 272
  stack        : [ i32.const 272 ; i32.const 40 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 272
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 276
  stack        : [ i32.const 276 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 276 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 280
  stack        : [ i32.const 280 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 280 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 284
  stack        : [ i32.const 284 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 284 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 288
  stack        : [ i32.const 288 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 288 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 292
  stack        : [ i32.const 292 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 292 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 296
  stack        : [ i32.const 296 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 296 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 272
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 44
  stack        : [ i32.const 44 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 300
  stack        : [ i32.const 300 ; i32.const 44 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 300
  stack        : [ i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 304
  stack        : [ i32.const 304 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 5
  stack        : [ i32.const 5 ; i32.const 304 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 308
  stack        : [ i32.const 308 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 308 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 312
  stack        : [ i32.const 312 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 312 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 316
  stack        : [ i32.const 316 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 316 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 320
  stack        : [ i32.const 320 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 320 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 324
  stack        : [ i32.const 324 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 324 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.store 
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 300
  stack        : [ i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: local.set 0
  stack        : [ i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.load 
  stack        : [ i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.add
  stack        : [ i32.const 4 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.load 
  stack        : [ i32.const 10 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 10 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.gt_s
  stack        : [ i32.const 1 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: (if  
    (then
      nop
    )
    (else
      unreachable
    )
  )
  stack        : [ i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: nop
  stack        : [ i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  stack        : [ i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: local.get 0
  stack        : [ i32.const 0 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 8
  stack        : [ i32.const 8 ; i32.const 0 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 0
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 0 ; i32.const 8 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.mul
  stack        : [ i32.const 0 ; i32.const 8 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.add
  stack        : [ i32.const 8 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.load 
  stack        : [ i32.const 48 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.const 4
  stack        : [ i32.const 4 ; i32.const 48 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.add
  stack        : [ i32.const 52 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.load 
  stack        : [ i32.const 5 ; i32.const 10 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: i32.add
  stack        : [ i32.const 15 ; i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 300 ; i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 272 ; i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 244 ; i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 216 ; i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 188 ; i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 160 ; i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 132 ; i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 104 ; i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 76 ; i32.const 48 ]
  running instr: drop
  stack        : [ i32.const 48 ]
  running instr: drop
  stack        : [  ]
  stack        : [  ]
