# begin...end
用于将多个语句分组到一个<font color=blue>顺序快</font>  
当块中只有一个语句，那么begin...end可以省略  

# disable
用于终止一个命名的过程语句快或一个task  
也能用于推出循环  

# repeat-执行固定次数的循环
```verilog
repeat (expression)
    statement or block of statesment
```
固定次数由一个常数给定  
如果expression的值为x 或者z,那么循环将不会执行  
