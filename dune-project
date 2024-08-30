(lang dune 3.0)

(using mdx 0.2)

(name miniml2wasm)

(cram enable)

(using menhir 2.1)

(license Unlicense)

(authors "Eric Patrizio <epatrizio@mpns.fr>")

(maintainers "Eric Patrizio <epatrizio@mpns.fr>")

(source
 (github epatrizio/miniml2wasm))

(generate_opam_files true)

(implicit_transitive_deps false)

(package
 (name miniml2wasm)
 (synopsis "OCaml MiniML to WebAssembly compiler")
 (description
  "OCaml MiniML to WebAssembly compiler. Experimental project, work in progress ...")
 (tags
  (miniml2wasm ocaml miniml wasm webassembly compiler))
 (depends
  (ocaml
   (>= 4.14))
  sedlex
  (menhir
   (and
    :build
    (>= 20220210)))
  (odoc :with-doc)
  (mdx
   (and
    :with-test
    (>= "2.1")))))
