# 3.1 过程结构
过程结构语句： `initial`与`always`语句  
一个模块中可以包含多个initial,always  
两个语句<font color=red>不能嵌套使用</font>。  

**<font color=purple>这些语句在模块间并行执行，与其在模块的前后顺序无关</font>**  

## initial语句
`initial`语句 **从 0 时刻开始执行,只执行一次**  
多个`initial`块之间是 **相互独立**的。  
initial块中的语句是<font color=purple>按顺序执行</font>的  
如果 initial 块内包含多个语句，需要使用关键字 `begin` 和 `end` 组成一个块语句。  
如果 initial 块内只要一条语句，关键字 begin 和 end 可使用也可不使用。  
如`initial a = 1;`  
实例如下:  
```verilog
`timescale 1ns/1ns
 
module test ;
    reg  ai, bi ;
 
    initial begin
        ai         = 0 ;
        #25 ;      ai        = 1 ;
        #35 ;      ai        = 0 ;        //absolute 60ns
        #40 ;      ai        = 1 ;        //absolute 100ns
        #10 ;      ai        = 0 ;        //absolute 110ns
    end
 
    initial begin
        bi         = 1 ;
        #70 ;      bi        = 0 ;        //absolute 70ns
        #20 ;      bi        = 1 ;        //absolute 90ns
    end
 
    //at proper time stop the simulation
    initial begin
        forever begin
            #100;
            //$display("---gyc---%d", $time);
            if ($time >= 1000) begin
                $finish ;
            end
        end
   end
 
endmodule
```

## always 语句
- **特点**: 
    - always语句是**重复执行**的。
    - always语句块**从0时刻开始执行**其中的行为语句
    - 当执行完最后一条语句后，便再次执行语句块中的第一条语句，如此循环反复  

- **实例**:产生一个100MHz时钟源，并在1010ns时停止仿真
```verilog
`timescale 1ns/1ns
 
module test ;
 
    parameter CLK_FREQ   = 100 ; //100MHz = 1e8Hz
    parameter CLK_CYCLE  = 1e9 / (CLK_FREQ * 1e6) ;   //周期，并把单位switch to ns
 
    reg  clk ;
    initial      clk = 1'b0 ;      //clk is initialized to "0"
    always     # (CLK_CYCLE/2) clk = ~clk ;       //generating a real clock by reversing
 
    always begin
        #10;
        if ($time >= 1000) begin
            $finish ;
        end
    end
 
endmodule
```
### always块注意点
<font color=red>不能使用assign</font>  

### always语句块的使用

```verilog
always @(<敏感事件列表>)
各可执行的语句;
...
```

#### 敏感事件列表
1. 敏感事件列表中列出了所有<font color=purple>影响always块中输出的信号清单</font>  
2. 如模块中变量的值，上升沿等等  
3. 当敏感事件列表中任一变量发生了变化时，便会执行always语句块中的语句  
    - `always @ (a or b or s)`: 表示只要a,b,s中任何一个发生了变化，就立刻执行always语句块中的语句
4. 也可以用*代替，如`always @ (*)` 
    - `*`将自动包含always语句块中语句右边出现或条件表达式中的所有信号  

#### always的输出信号必须被描述成reg型  

# Verilog过程赋值
过程性赋值是在inital或always语句块里的赋值，赋值对象是`寄存器，整数，实数`(<font color=red>即reg型</font>)等类型  

过程赋值语句： `阻塞赋值`与`非阻塞赋值`  

连续性赋值与过程性赋值的区别: 
> <font color=red>连续性赋值总是处于激活状态，任何操作数的改变都会影响表达式的结果；过程赋值只有在语句执行的时候，才会起作用。</font>  

## 阻塞赋值
属于 **顺序执行**，即下一条语句执行前，当前语句一定会执行完毕  
使用`=`作为赋值符  

## 非阻塞赋值
非阻塞赋值属于 **并行执行语句**，即下一条语句的执行和当前<font color=purple>语句的执行是同时进行</font>的，它不会阻塞位于同一个语句块中后面语句的执行。  
使用`<=`作为赋值符  

## 使用非阻塞赋值避免竞争风险
实际verilog代码设计中，<font color=red>不要</font>在一个过程结构中混合使用阻塞赋值和非阻塞赋值。  
`always时序逻辑快`中多用`非阻塞赋值`  
`always组合逻辑块`中多用`阻塞赋值`  
`inital块`中一般用`阻塞赋值`  
一个实例介绍:(实现在时钟上升沿交换两个寄存器值的功能)  
```verilog
always @(posedge clk) begin
    a = b ;
end
 
always @(posedge clk) begin
    b = a;
end
```
> 该实例不管a=b 或 b = a谁先执行，总存在一个先后，导致最后的结果为 a与b相等。  
> 这就造成了一个竞争

> 使用非阻塞赋值避免竞争风险
```verilog
always @(posedge clk) begin
    a <= b ;
end
 
always @(posedge clk) begin
    b <= a;
end
```
>> 使得a = b， b = a  

## 过程连续性赋值
过程连续赋值发生作用时，右端表达式任意操作数发生变化时，都会重新执行过程连续赋值语句  

### assign 与 deassign
 <font color=red>可用于reg型</font>  
deassign用于取消过程赋值操作  

### force 与 release
 <font color=red>可用于reg和wire型</font>  
`force` (强制赋值操作) `release` (取消强制赋值操作)  
在`force`作用期间，该变量的值不可以被原有的过程赋值语句改变  
使用`release`语句，可以取消强制赋值  
> 若是对wire型变量操作,使用release后，该变量的值将马上变为原来的驱动值  
> 若是瑞reg型变量操作，使用release后，该变量的值将继续保留被强制赋值时的值，不过其值可以被原有的过程性赋值改变  





















