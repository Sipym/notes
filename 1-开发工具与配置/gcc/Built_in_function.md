# 内置函数
## __builtin_expect()
```c
long __builtin_expect(long exp, long c)
```
**作用**:您可以使用 `__builtin_expect` 为编译器提供分支预测信息  

**内置的语义**:是希望`exp == c`  
以一个实例来理解它的语义:  
   ```c
if (__builtin_expect (x, 0))
    foo (); 
```
这段程序表示: **我们不希望调用foo()**, <font color=purple>因为我们期望`x == 0`</font>  
