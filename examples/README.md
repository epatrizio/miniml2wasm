# Examples

These first small examples show how to use `miniml` language in close real-life contexts.

- [Factorial implementations](https://en.wikipedia.org/wiki/Factorial): `dune exec miniml2wasm -- fact.mml`

- [Fibonacci implementations](https://en.wikipedia.org/wiki/Fibonacci_sequence): `dune exec miniml2wasm -- fibo.mml`

- [Javascript integrations](https://developer.mozilla.org/en-US/docs/WebAssembly/Using_the_JavaScript_API):
  - `print.mml`: displays 42 (i32) - import `print_i32` function
  - `print.js`:
    - host function `print_i32` definition and wasm module print.wasm (print.mml compilation result) loading
    - `deno run --allow-read print.js`: execution with [deno (a modern js runtime)](https://deno.com)
  - `import.mml`: user is prompted to enter an i32 and compute(i32) result is displayed - import `print_i32`, `read_i32` and `compute` functions
  - `import.js`:
    - host function `print_i32`, `read_i32` and `compute` definitions and wasm module import.wasm (import.mml compilation result) loading
    - `deno run --allow-read import.js`
  - `export.mml`: exports a function whose name is `double`
  - `export.js`: `double` function (defined in the `export.wasm` module) call
  - `list.mml`: some list manipulations
  - `list.js`: key point = lists are created in the wasm module: They are allocated in wasm's linear memory and can therefore be easily used.

*fact, fibo, export and print examples are part of the cram test suite*

*import has to be run manually (infinite loop)*
