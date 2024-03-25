# Makefile 的条件判断
```make
ifeq ($(CC),gcc)
    $(CC) -o foo $(objects) $(libs_for_gcc)
else
    $(CC) -o foo $(objects) $(normal_libs)
endif
```
## 条件是否相等
1. `ifeq`: 表示条件语句的开始,并指定了一个比较条件  
    > ifeq之后是用圆括号包围的，使用`，`分割的两个参数  
    > 有时第二参数为空: 即用来<font color=purple>比较第一个参数是否为空</font>  

2. `else`: 之后就是当条件不满足时执行部分  

3. `endif`: 一个条件语句的结束  

## 条件是否不相等 ifneq
和上面类似  

## 变量是否定义 ifdef 
`ifdef 变量名`  
> :ifdef 只是测试一个变量是否有值,<font color=purple>不会判断值是否为空</font>  


