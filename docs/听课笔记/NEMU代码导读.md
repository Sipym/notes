# make相关
了解程序/工具行为的两种方法
- 看源码: 可以得知每一处<font color=green>静态</font>,但<font color=red>较繁琐</font>  
- 看踪迹: 容易了解运行<font color=green>动态</font>行为，但<font color=red>不全面</font>  

make踪迹也有不同的层次:  
- `strace`-系统调用踪迹，查看程序/工具如何与操作系统交互
- `make -d` - make工具的调试日志，查看make如何进行决策
- `make -n` - 面向上层用户的日志，只想了解make执行来那些命令来编译NEMU时使用  

`stat`系统调用可以查询文件信息  
    - 可以获取如文件修改的时间


可以通过make -d输出make工具的调试日志  

makefile隐含规则:  
如果遇到一个.o文件且没有给出规则，就看看是否有相应的.c文件，如果有就使用一下隐含规则  
```makefile
%.o: %.c
    $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ %^
```

# vim相关
使用`:tabview 文件名`，可以在新窗口打开指定文件  



# linux
命令wc  

# 如何去寻找一个函数?
寻找nemu下的`main()`函数  
- RTFSC方法  
- UNIx方法: `grep -nr "\bmain\b" nemu/src`
- GDB方法(<font color=red>推荐</font>):  
```gdb
make menuconfig 
make clean
make gdb
(gdb) b main  # 这里是对main打一个断点，就可以显示main函数所在位置，即断点所在位置  
```

## gdb
- 通过TUI在gdb中打开一个源码窗口
`(gdb) layout src   # layout split还可以看到汇编代码`  
一些常用的GDB命令  
- `r`-重新开始执行程序
- `s`-但不执行一行源代码/`n`-类似但不仅如函数(可以用于跳过库函数)  
- `finish`- 执行知道当前函数返回  
- `p`- 打印变量或寄存器的值  
- `x`-扫描内存  
- `bt`-查看调用栈  
- `b`-设置断点/`watch`-设置监视点  
- `help xxx`-查看`xxx`命令的帮助  

