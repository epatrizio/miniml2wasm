;; wip: produced by the compiler, corrected by hand
(module
  (type $0 (func))
  (type $1 (func (param i32)))
  (import "mod" "print_i32" (func $0 (type 1))) ;; (Bug: type 0)
  (func $1
    (type 0)
    (local i32)
    (i32.const 42)
    (local.set 0)
    (local.get 0)
    (call 0)
    ;; (drop)   (Bug)
  )
  (start 1)   ;; (Bug: start 0)
)
