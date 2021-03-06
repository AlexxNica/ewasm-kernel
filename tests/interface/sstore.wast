;; starts with an caller of 5d48c1018904a172886829bbbd9c6f4a2d06c47b
(module
  (import "ethereum" "storageStore" (func $sstore (param i32 i32 i32)))
  (import "ethereum" "storageLoad"  (func $sload (param i32 i32 i32)))

  (memory 1)
  (export "memory" (memory 0))

  (table
    (export "callback")
    anyfunc
    (elem
      $callback
      $callback2
    )
  )

  (func $main
    (export "main")
    (local $temp i64)
    (block
      ;; should roundtrip store and load a value from storage
      (i64.store (i32.const 0) (i64.const 173553719826446289))
      (call $sstore (i32.const 64) (i32.const 0) (i32.const 0))
    )
  )

  (func $callback
    (block
      (call $sload (i32.const 64) (i32.const 64) (i32.const 1))
    )
  )

  (func $callback2
    (block
      (if (i64.ne (i64.load (i32.const 64)) (i64.const 173553719826446289))
        (unreachable))

    )
  )
)
