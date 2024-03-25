# case语句
```verilog
//格式如下
   case (<2-bit select>)
      2'b00  : begin
                  <statement>;
               end
      2'b01  : begin
                  <statement>;
               end
      2'b10  : begin
                  <statement>;
               end
      2'b11  : begin
                  <statement>;
               end
      default: begin
                  <statement>;
               end
   endcase
```
如果要在满足某个表达式值时，执行多条语句，<font color=purple>要用`begin`和`end`将这些语句扩起来</font>  
case语句的所有表达式的值的`位宽`必须<font color=blue>相等</font>  
case分支<font color=red>不允许出现`x,z,?`</font>  

# casez语句
可以与？配合，可以过滤不相关的比特位。  
但是同样<font color=red>不能含有x,z</font>  
```verilog
reg[7:0] ir;
casez(ir)
8 'b1???????: instruction1(ir);
8 'b01??????: instruction2(ir);
8 'b00010???: instruction3(ir);
8 'b000001??: instruction4(ir);
endcase
```

#casex语句
在可综合设计中，只能用case和casez，不能用casex。  
因为综合时casex中的x和z都被视为don’t care，综合前后仿真结果不一致。  

