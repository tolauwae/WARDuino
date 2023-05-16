
(module
  ;; Auxiliary definition
  (func $dummy)

  (func (export "type-i32") (drop (i32.ctz (return))))
  (func (export "type-i64") (drop (i64.ctz (return))))
  (func (export "type-f32") (drop (f32.neg (return))))
  (func (export "type-f64") (drop (f64.neg (return))))

  (func (export "type-i32-value") (result i32)
    (block (result i32) (i32.ctz (return (i32.const 1))))
  )
  (func (export "type-i64-value") (result i64)
    (block (result i64) (i64.ctz (return (i64.const 2))))
  )
  (func (export "type-f32-value") (result f32)
    (block (result f32) (f32.neg (return (f32.const 3))))
  )
  (func (export "type-f64-value") (result f64)
    (block (result f64) (f64.neg (return (f64.const 4))))
  )

  (func (export "nullary") (return))
  (func (export "unary") (result f64) (return (f64.const 3)))

  (func (export "as-func-first") (result i32)
    (return (i32.const 1)) (i32.const 2)
  )
  (func (export "as-func-mid") (result i32)
    (call $dummy) (return (i32.const 2)) (i32.const 3)
  )
  (func (export "as-func-last")
    (nop) (call $dummy) (return)
  )
  (func (export "as-func-value") (result i32)
    (nop) (call $dummy) (return (i32.const 3))
  )

  (func (export "as-block-first")
    (block (return) (call $dummy))
  )
  (func (export "as-block-mid")
    (block (call $dummy) (return) (call $dummy))
  )
  (func (export "as-block-last")
    (block (nop) (call $dummy) (return))
  )
  (func (export "as-block-value") (result i32)
    (block (result i32) (nop) (call $dummy) (return (i32.const 2)))
  )

  (func (export "as-loop-first") (result i32)
    (loop (result i32) (return (i32.const 3)) (i32.const 2))
  )
  (func (export "as-loop-mid") (result i32)
    (loop (result i32) (call $dummy) (return (i32.const 4)) (i32.const 2))
  )
  (func (export "as-loop-last") (result i32)
    (loop (result i32) (nop) (call $dummy) (return (i32.const 5)))
  )

  (func (export "as-br-value") (result i32)
    (block (result i32) (br 0 (return (i32.const 9))))
  )

  (func (export "as-br_if-cond")
    (block (br_if 0 (return)))
  )
  (func (export "as-br_if-value") (result i32)
    (block (result i32)
      (drop (br_if 0 (return (i32.const 8)) (i32.const 1))) (i32.const 7)
    )
  )
  (func (export "as-br_if-value-cond") (result i32)
    (block (result i32)
      (drop (br_if 0 (i32.const 6) (return (i32.const 9)))) (i32.const 7)
    )
  )

  (func (export "as-br_table-index") (result i64)
    (block (br_table 0 0 0 (return (i64.const 9)))) (i64.const -1)
  )
  (func (export "as-br_table-value") (result i32)
    (block (result i32)
      (br_table 0 0 0 (return (i32.const 10)) (i32.const 1)) (i32.const 7)
    )
  )
  (func (export "as-br_table-value-index") (result i32)
    (block (result i32)
      (br_table 0 0 (i32.const 6) (return (i32.const 11))) (i32.const 7)
    )
  )

  (func (export "as-return-value") (result i64)
    (return (return (i64.const 7)))
  )

  (func (export "as-if-cond") (result i32)
    (if (result i32)
      (return (i32.const 2)) (then (i32.const 0)) (else (i32.const 1))
    )
  )
  (func (export "as-if-then") (param i32 i32) (result i32)
    (if (result i32)
      (local.get 0) (then (return (i32.const 3))) (else (local.get 1))
    )
  )
  (func (export "as-if-else") (param i32 i32) (result i32)
    (if (result i32)
      (local.get 0) (then (local.get 1)) (else (return (i32.const 4)))
    )
  )

  (func (export "as-select-first") (param i32 i32) (result i32)
    (select (return (i32.const 5)) (local.get 0) (local.get 1))
  )
  (func (export "as-select-second") (param i32 i32) (result i32)
    (select (local.get 0) (return (i32.const 6)) (local.get 1))
  )
  (func (export "as-select-cond") (result i32)
    (select (i32.const 0) (i32.const 1) (return (i32.const 7)))
  )

  (func $f (param i32 i32 i32) (result i32) (i32.const -1))
  (func (export "as-call-first") (result i32)
    (call $f (return (i32.const 12)) (i32.const 2) (i32.const 3))
  )
  (func (export "as-call-mid") (result i32)
    (call $f (i32.const 1) (return (i32.const 13)) (i32.const 3))
  )
  (func (export "as-call-last") (result i32)
    (call $f (i32.const 1) (i32.const 2) (return (i32.const 14)))
  )

  (type $sig (func (param i32 i32 i32) (result i32)))
  (table funcref (elem $f))
  (func (export "as-call_indirect-func") (result i32)
    (call_indirect (type $sig)
      (return (i32.const 20)) (i32.const 1) (i32.const 2) (i32.const 3)
    )
  )
  (func (export "as-call_indirect-first") (result i32)
    (call_indirect (type $sig)
      (i32.const 0) (return (i32.const 21)) (i32.const 2) (i32.const 3)
    )
  )
  (func (export "as-call_indirect-mid") (result i32)
    (call_indirect (type $sig)
      (i32.const 0) (i32.const 1) (return (i32.const 22)) (i32.const 3)
    )
  )
  (func (export "as-call_indirect-last") (result i32)
    (call_indirect (type $sig)
      (i32.const 0) (i32.const 1) (i32.const 2) (return (i32.const 23))
    )
  )

  (func (export "as-local.set-value") (result i32) (local f32)
    (local.set 0 (return (i32.const 17))) (i32.const -1)
  )
  (func (export "as-local.tee-value") (result i32) (local i32)
    (local.tee 0 (return (i32.const 1)))
  )
  (global $a (mut i32) (i32.const 0))
  (func (export "as-global.set-value") (result i32)
    (global.set $a (return (i32.const 1)))
  )

  (memory 1)
  (func (export "as-load-address") (result f32)
    (f32.load (return (f32.const 1.7)))
  )
  (func (export "as-loadN-address") (result i64)
    (i64.load8_s (return (i64.const 30)))
  )

  (func (export "as-store-address") (result i32)
    (f64.store (return (i32.const 30)) (f64.const 7)) (i32.const -1)
  )
  (func (export "as-store-value") (result i32)
    (i64.store (i32.const 2) (return (i32.const 31))) (i32.const -1)
  )

  (func (export "as-storeN-address") (result i32)
    (i32.store8 (return (i32.const 32)) (i32.const 7)) (i32.const -1)
  )
  (func (export "as-storeN-value") (result i32)
    (i64.store16 (i32.const 2) (return (i32.const 33))) (i32.const -1)
  )

  (func (export "as-unary-operand") (result f32)
    (f32.neg (return (f32.const 3.4)))
  )

  (func (export "as-binary-left") (result i32)
    (i32.add (return (i32.const 3)) (i32.const 10))
  )
  (func (export "as-binary-right") (result i64)
    (i64.sub (i64.const 10) (return (i64.const 45)))
  )

  (func (export "as-test-operand") (result i32)
    (i32.eqz (return (i32.const 44)))
  )

  (func (export "as-compare-left") (result i32)
    (f64.le (return (i32.const 43)) (f64.const 10))
  )
  (func (export "as-compare-right") (result i32)
    (f32.ne (f32.const 10) (return (i32.const 42)))
  )

  (func (export "as-convert-operand") (result i32)
    (i32.wrap_i64 (return (i32.const 41)))
  )

  (func (export "as-memory.grow-size") (result i32)
    (memory.grow (return (i32.const 40)))
  )
)

