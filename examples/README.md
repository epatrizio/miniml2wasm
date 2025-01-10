# Examples

These first small examples show how to use `miniml` language in close real-life contexts.

- [Factorial implementation](https://en.wikipedia.org/wiki/Factorial): `dune exec miniml2wasm -- fact.mml`

- [Javascript integration](https://developer.mozilla.org/en-US/docs/WebAssembly/Using_the_JavaScript_API):
  - `print.wat` (Wasm module): displays 42 (i32) - import print_i32 function
  - `print.js`:
    - host function print_i32 definition and wasm module print.wasm loading
    - `deno run --allow-read print.js`: execution with [deno, modern js runtime](https://deno.com)
  - `read.wat` (Wasm module): user is prompted to enter an i32 and i32*2 is displayed - import print_i32 and read_i32 functions
  - `read.js`:
    - host function print_i32 and read_i32 definitions and wasm module read.wasm loading
    - `deno run --allow-read read.js`

*Nb. Example print is part of the cram test suite*
