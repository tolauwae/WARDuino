       (assert_return (invoke "add" (f32.const -0x0p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "add" (f32.const 0x0p+0) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "add" (f32.const 0x0p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const -0x0p+0) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x0p+0) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x0p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const -0x1p-149) (f32.const -0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x1p-149) (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const -0x1p-126) (f32.const -0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x1p-126) (f32.const 0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const -0x1p-1) (f32.const -0x1p-1)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x1p-1) (f32.const 0x1p-1)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const -0x1p+0) (f32.const -0x1p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x1p+0) (f32.const 0x1p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const -0x1.921fb6p+2) (f32.const -0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x1.921fb6p+2) (f32.const 0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const -0x1.fffffep+127) (f32.const -0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "sub" (f32.const 0x1.fffffep+127) (f32.const 0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x0p+0) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x0p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x0p+0) (f32.const -0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x0p+0) (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x0p+0) (f32.const -0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x0p+0) (f32.const 0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x0p+0) (f32.const -0x1p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x0p+0) (f32.const 0x1p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x0p+0) (f32.const -0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x0p+0) (f32.const 0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x0p+0) (f32.const -0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x0p+0) (f32.const 0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1p-149) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1p-149) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1p-149) (f32.const -0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1p-149) (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1p-149) (f32.const -0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1p-149) (f32.const 0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1p-126) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1p-126) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1p-126) (f32.const -0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1p-126) (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1p-126) (f32.const -0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1p-126) (f32.const 0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1p+0) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1.921fb6p+2) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1.921fb6p+2) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const -0x1.fffffep+127) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "mul" (f32.const 0x1.fffffep+127) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const -0x0p+0) (f32.const -0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const -0x0p+0) (f32.const -0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const -0x0p+0) (f32.const -0x1p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const 0x0p+0) (f32.const 0x1p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const -0x0p+0) (f32.const -0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const 0x0p+0) (f32.const 0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const -0x0p+0) (f32.const -0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const 0x0p+0) (f32.const 0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const 0x1p-149) (f32.const 0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const 0x1p-149) (f32.const 0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "div" (f32.const 0x1p-126) (f32.const 0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x0p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x0p+0) (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x0p+0) (f32.const 0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x0p+0) (f32.const 0x1p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x0p+0) (f32.const 0x1.921fb6p+2)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x0p+0) (f32.const 0x1.fffffep+127)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x1p-149) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x1p-126) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x1p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x1.921fb6p+2) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const 0x1.fffffep+127) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "min" (f32.const inf) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "max" (f32.const -0x0p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "max" (f32.const 0x0p+0) (f32.const -0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "max" (f32.const 0x0p+0) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "max" (f32.const 0x0p+0) (f32.const -0x1p-1)) (f32.const 0x0p+0))
       (assert_return (invoke "max" (f32.const -0x1p-1) (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "sqrt" (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "floor" (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "floor" (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "floor" (f32.const 0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "ceil" (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "trunc" (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "trunc" (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "trunc" (f32.const 0x1p-126)) (f32.const 0x0p+0))
       (assert_return (invoke "nearest" (f32.const 0x0p+0)) (f32.const 0x0p+0))
       (assert_return (invoke "nearest" (f32.const 0x1p-149)) (f32.const 0x0p+0))
       (assert_return (invoke "nearest" (f32.const 0x1p-126)) (f32.const 0x0p+0))