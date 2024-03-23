# 每个Chisel必须包含的部分
```scala
val path = System.getProperty("user.dir") + "/source/load-ivy.sc"
interp.load.module(ammonite.ops.Path(java.nio.file.FileSystems.getDefault().getPath(path)))

import chisel3._
import chisel3.util._
import chisel3.tester._
import chisel3.tester.RawTester.test
```
# 如何创建一个Chisel模块，可用于生成verilog模块
```scala
// Chisel Code: Declare a new module definition
class Passthrough extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(4.W))
    val out = Output(UInt(4.W))
  })
  io.out := io.in
}
```
## 解析
所有硬件模块类，必须包含 `extend Module`  
所有的input，output信号定义应在val io中  
```scala
val io = IO(_instantiated_bundle_)
```
我们声明了一个新的硬件结构类型（Bundle），其中包含一些命名信号输入和输出，分别具有输入和输出方向。
```scala
new Bundle {
    val in = Input(...)
    val out = Output(...)
}
```
4位宽的无符号整形  
```scala
UInt(4.W)
```
:=操作符是具有方向的，表示右边的信号驱动了左边的信号  
```scala
io.out := io.in
```

## 如何由Chisel生成verilog代码
```scala
println(getVerilog(new Passthrough))
```

一个可指定位宽的Chisel模块  
因为下面模块可以生成多个模块，我们将其称为一个生成器  
```scala
// Chisel Code, but pass in a parameter to set widths of ports
class PassthroughGenerator(width: Int) extends Module { 
  val io = IO(new Bundle {
    val in = Input(UInt(width.W))
    val out = Output(UInt(width.W))
  })
  io.out := io.in
}

//生成带有不同的位宽的Verilog模块
println(getVerilog(new PassthroughGenerator(10)))
println(getVerilog(new PassthroughGenerator(20)))
```

## 一个简单的Chisel模块示例  
```scala
class MyModule extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(4.W))
    val out = Output(UInt(4.W))
  })

  val two  = 1 + 1
  println(two)
  val utwo = 1.U + 1.U
  println(utwo)
  
  io.out := io.in
}
```
等效的verilog  
```verilog
module MyModule(
  input        clock,
  input        reset,
  input  [3:0] io_in,
  output [3:0] io_out
);
  assign io_out = io_in; // @[cmd2.sc 12:10]
endmodule
```

# 测试模块,可以用来分配输入引脚值，测试输出的值是否符合预计 
```scala
test(new Passthrough()) { c =>
    c.io.in.poke(0.U)     // Set our input to value 0
    c.io.out.expect(0.U)  // Assert that the output correctly has 0
    c.io.in.poke(1.U)     // Set our input to value 1
    c.io.out.expect(1.U)  // Assert that the output correctly has 1
    c.io.in.poke(2.U)     // Set our input to value 2
    c.io.out.expect(2.U)  // Assert that the output correctly has 2
}
println("SUCCESS!!") // Scala Code: if we get here, our tests passed!
```

# poke 与 expect 与 peek
poke: 用于分配值给input
expect: 用于检查输出，即assert
peek: 用于查看输出

## poke
poke的值应该与信号的类型一样  
>如Uint型的应该使用如10.U  
>如Bool型的应该使用如true.B  


# step
以一个时间单元执行电路，如`c.clock.step(1)`

