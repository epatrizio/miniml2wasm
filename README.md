# miniml2wasm - MiniML to WebAssembly compiler written in OCaml

This project is a compiler of a `miniml` language to [WebAssembly](https://webassembly.org) (in bytecode format)
written in [OCaml](https://ocaml.org) with the [Dune](https://dune.build) build system.

- Build standard command: `dune build @all`
- Execute [Cram test](https://dune.readthedocs.io/en/stable/tests.html): `dune test` or `dune runtest`
- Run: `dune exec miniml2wasm -- file_name.mml`
- Run in debug mode: `dune exec miniml2wasm -- file_name.mml --debug`

Debug mode displays the `miniml` input file twice in the console:
original version - after scope analysis version (variables renamed with a unique name).

```sh
$ dune exec -- miniml2wasm --help
usage: dune exec miniml2wasm -- file_name.ml [options]
  --debug  Debug mode
  -help  Display this list of options
  --help  Display this list of options
```

## Non-formal language specification elements

My `miniml` is a small fragment of a ML-language whose syntax is very similar to OCaml.
Typing is static, strong, inferred.

A `miniml` program is a sequence of expressions (a block).
An expression produces a typed value.
A block is also an expression (only the last expression of the sequence may not be of type `unit`)
A statement should be seen as an expression of type unit.

Summary of supported language features:

- Value types: unit, bool, i32, reference of type, array of type (fixed size)
- Expressions: Constants, unary and binary operations, blocks, if condition, let binding local and global, array
- Statements: assignements, while loop, array_size and print primitives

Example of some language main features:

<!-- $MDX file=test/42.mml -->
```ml
(* supported types: unit, bool, i32, ref, array, 2-dim matrix *)
(* type is optional, it can be inferred *)

(* global scope *)

let x = 40;
(* let arr : bool[2] = [true,true]; *)
(* array are not supported in a global context *)

(* local scope *)

(* var is immutable by default *)
let y : i32 = 2 in
(* var should by mutable *)
let z : i32 ref = ref 0 in
(* user input *)
let r : i32 = read_i32 in
(* array construct *)
(* array must be initialized to set the fully type (elements type and size) *)
let array : bool[2] = [true,true] in
(* matrix construct *)
let matrix : i32[2][3] = [[0,0],[1,1],[2,2]] in
  begin  (* block *)
    (* primitive function: assert. If false-cond, a trap is emit *)
    assert true;
    while true do (* loop-cond must be in bool type *)
      (* mutable var assign *)
      z := 42;
      (* array col assign *)
      array[0] := false;
      (* if-cond must be in bool type *)
      (* imported function: print_i32 *)
      if not true then print_i32 42
      else print_i32 -42;
      (* primitive function: array_size *)
      array_size array
    done;
    (* unary opertations: - not *)
    (* binary opertations: + - * / == != < <= > => *)
    (x + y)
  end
```

Compilation steps:

```shell-session
$ dune exec miniml2wasm -- fact.mml
parsing ...
scope analysing ...
typechecking ...
compiling ...
compilation target file _wasm/fact.wasm: done!
```

See [test suite files](https://github.com/epatrizio/miniml2wasm/tree/main/test/) for examples of all language elements.

## WebAssembly tools

To program and test, I use the following tools:

- [Reference interpreter](https://github.com/WebAssembly/spec/tree/main/interpreter) to convert text<>binary format
- [Owi](https://github.com/OCamlPro/owi) to interpret with a stack trace display

Here is the command sequence used for testing:

```shell-session
$ dune exec miniml2wasm -- test/42.mml
$ wasm -d _wasm/42.wasm -o _wasm/42.wat
$ owi _wasm/42.wat --debug
```

Here are some more classic tools:

- [WABT: The WebAssembly Binary Toolkit](https://github.com/WebAssembly/wabt)
- [Binaryen](https://github.com/WebAssembly/binaryen): optimizations and other stuffs

## Why ?

It’s always difficult to write a compiler! More difficult than writing an [interpreter](https://github.com/epatrizio/ola/).
This project allows me to experiment and gives me a better understanding of ML-languages
and the [Wasm bytecode](https://webassembly.github.io/spec/core/binary/index.html).

## Current status

This is the very beginning of the project. Its status is experimental.\
However, It's already possible to do some fun stuff, and when functions will be supported (next step),
this `miniml` language fragment will start to look interesting.

- See [./examples](https://github.com/epatrizio/miniml2wasm/tree/main/examples)
- See [./test/compiler](https://github.com/epatrizio/miniml2wasm/tree/main/test/compiler)

## Contribute

*More fun in a group than alone!*

Feel free: Contact me, suggest issues and pull requests.
