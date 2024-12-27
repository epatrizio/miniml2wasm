;; wip: manual example
(module
  (type $0 (func))
  (type $1 (func (param i32)))
  (type $2 (func (result i32)))
  (import "mod" "print_i32" (func $0 (type 1)))
  (import "mod" "read_i32" (func $1 (type 2)))
  (func $2
    (type 0)
    (call 1)  ;; user input (#ui) push on stack
    i32.const 2
    i32.mul
    (call 0)  ;; print ui*2
  )
  (start 2)
)
