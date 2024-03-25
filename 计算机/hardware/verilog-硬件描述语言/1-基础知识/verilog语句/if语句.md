# if-条件语句
格式如下:  
```verilog
//标准格式
if (conditions) begin
    command;
    ...
    end
else begin
    command;
    ...
    end
//只有一个命令时，可以不用写begin，end
if (conditions)
    command;
else
    command;

```

如果if语句在使用时，没有else语句与其配对  
> 编译器会判断if后的条件表达式是否满足，如果满足则执行其后的语句  
> **如果不满足**,编译器会自动生成一个**寄存器**来寄存当前的值，在条件不满足时保输出的过去值  
>> <font color=red>这样会产生用户没有设计的多余寄存器出来</font>  
>> 因此建议读者在使用if语句的时候加上else语句预期配对
