compiler unused_vars:
  $ dune exec miniml2wasm -- unused_vars.mml --unused-vars
  parsing ...
  unused vars checking ...
  Warning: unused global variable g2
  Warning: unused local variable l1
  scope analysing ...
  typechecking ...
  compiling ...
  compilation target file _wasm/unused_vars.wasm: done!
