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
  --unused-vars  Unused variables checking
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

- Value types: unit, bool, i32, reference of type, array of type (fixed size), function
- Expressions: Constants, unary and binary operations, blocks, if condition, let binding local and global, array, function (init & call)
- Statements: assignements, while loop, array_size and assert primitives

Example of some language main features:

<!-- $MDX file=test/42.mml -->
```ml
(* supported types: unit, bool, i32, ref, array, 2-dim matrix *)
(* type is optional, it can be inferred *)

(* global scope *)

(* imported function: print_i32 *)
(* imported functions are only supported at the beginning of the global scope *)
let print_i32 : i32 -> unit = import fun(i32) : unit;

let x = 40;

(* let arr : bool[2] = [true,true]; *)
(* arrays are not supported in a global context *)

(* let li : bool list = true :: nil; *)
(* lists are not supported in a global context *)

(* function can be global and local *)
(* export - optional attribute - functions must be global *)
(* return type can be inferred, argument type not! *)
(*   > more details about typing in the following documentation *)
let identity (*: i32 -> i32*) = export fun(x : i32) (*: i32*) {
  x
};

(* local scope *)

(* var is immutable by default *)
let y : i32 = 2 in
(* var should by mutable *)
let z : i32 ref = ref 0 in
(* array construct: direct or with array_make primitive function *)
(* array must be initialized to set the fully type (elements type and size) *)
(* let array : bool[2] = array_make 2 true in *)
let array : bool[2] = [true,true] in
(* matrix construct: direct or with matrix_make primitive function *)
(* Warning: matrix_make x y default_val produces an i32[y][x] *)
(*          i32[y] must be seen as the array[x] first dim elements type *)
(*            (i32[y])[x] - elt_type[size] *)
(* let matrix : i32[2][3] = matrix_make 3 2 0 in *)
let matrix : i32[2][3] = [[0,0],[0,0],[0,0]] in
let li : i32 list = 42 :: 21 :: nil in
(* let li = nil in *)
(* nil: empty list, element types are unknown at this moment *)
(* let li = 42 :: li in *)
(* li type is inferred: i32 list *)
(* let li : i32 list = nil in *)
(* li type should be forced from the beginning *)
let li_hd = list_hd li in   (* head list: 42 *)
let li_tl = list_tl li in   (* tail list: 21 :: nil *)
  begin  (* block *)
    (* primitive function: assert. If false-cond, a trap is emit *)
    assert true;
    while true do (* loop-cond must be in bool type *)
      (* mutable var assign *)
      (* primitive function: array_size *)
      z := array_size array;
      (* array col assign *)
      array[0] := false;
      (* matrix field assign *)
      matrix[2][1] := 42;
      (* if-cond must be in bool type *)
      (* !z : dereference z var *)
      if not true then print_i32(!z)
      else print_i32(-(!z))
    done;
    (* unary opertations: - not *)
    (* binary opertations: + - * / == != < <= > => *)
    (* function call *)
    identity(x + y)
  end
```

Compilation steps:

```shell-session
$ dune exec miniml2wasm -- file_name.mml
parsing ...
unused vars checking ... ;; --unused-vars option
scope analysing ...
typechecking ...
compiling ...
compilation target file _wasm/file_name.wasm: done!
```

See [test suite files](https://github.com/epatrizio/miniml2wasm/tree/main/test/) for examples of all language elements.

### Type system focus

This implementation of `miniml` has a strong static typing but is not really [inferred](https://en.wikipedia.org/wiki/Type_inference).
Variables and expressions can be inferred. But not function arguments, whose types must be specified
([polymorphism](https://en.wikipedia.org/wiki/Parametric_polymorphism)). The idea would be to implement a type system like
[Hindley–Milner](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system), but it's complicated at this moment!

Like the very interesting [AssemblyScript](https://www.assemblyscript.org) language,
we're offering here a less powerful, sometimes limited, but sufficient and highly oriented type system to target WebAssembly.

### About import and export

This compiler specifically targets wasm, so it's interesting to implement these features:

- [import](https://webassembly.github.io/spec/core/binary/modules.html#binary-importsec):
function signatures to be implemented in the host language

- [export](https://webassembly.github.io/spec/core/binary/modules.html#binary-exportsec):
specific function (`export` #tag before definition) that can be called in the host language

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
However, It's already possible to do some fun stuff, this `miniml` language fragment will start to look interesting ;-)

- See [./examples](https://github.com/epatrizio/miniml2wasm/tree/main/examples)
- See [./test/compiler](https://github.com/epatrizio/miniml2wasm/tree/main/test/compiler)

## Contribute

*More fun in a group than alone!*

Feel free: Contact me, suggest issues and pull requests.
