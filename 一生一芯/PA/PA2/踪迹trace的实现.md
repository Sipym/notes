# trace与性能优化
- 可以基于ftrace进一步分析出调用memcpy()时的参数情况, 比如dest和src是否对齐, 拷贝的内存长度是长还是短, 然后根据频繁出现的组合对memcpy()的算法实现进行优化
- 可以基于ftrace统计函数调用的次数, 对访问次数较多的函数进行优化, 可以显著提升程序的性能
- 可以基于itrace过滤出分支跳转指令的执行情况, 作为分支预测器(现代处理器中的一个提升性能的部件)的输入, 来调整分支预测器的实现, 从而提升处理器的性能
- 可以基于mtrace得到程序的访存序列, 作为缓存(现代处理器中的另一个提升性能的部件)模型的输入, 对预取算法和替换算法的优化进行指导(你将会在Lab4中体会这一点)

## itrace - 指令执行的踪迹
**实现**: `nemu/src/cpu/cpu-exec.c`  
**原理**: 通过`snprintf`函数将`指令`，`当前pc`写入`Decode结构体`中的`字符数组log_buf`中。并通过函数`disassemble()`<font color=sky_blue>实现反汇编</font>(根据指令对应的机器码翻译出指令，如0000系列数字翻译成 add rd,rs1).最后通过`trace_and_difftest()`函数<font color=sky_blue>将`log_buf[]`写入log文件</font>      

## iringbuf - 指令环形缓冲区
**用途**: 实现在客户程序出错时(如访问物理内存越界)输出最近执行的若干条指令  
**暂时的实现内容**: 对`访问物理内存越界`时，输出指令环形缓冲区  

nemu程序报错: 我觉得只有两种  
   - `hit bad trap`: 由指令实现不对导致  
   - `out of bound`: 访问物理内存越界导致   

## mtrace - 内存访问踪迹
**开关**: 通过`make menuconfig`来打开  
**实现**: 执行pmem_read,pmem_write时，打印访问的内存地址  

## ftrace - 函数调用的踪迹
**符号表(symbol table)**: 可执行文件的一个部分,记录了程序编译时刻的一些信息  
   - `功能`: 用于跟踪程序中的标识符(函数名，变量名)以及相关的信息  
   - `作用`: 可以建立函数名与其地址之间的映射关系  
   - `用法`: `riscv64-linux-gnu-readelf -a XXX.elf`  

**字符串表(strtab)**: 把标识符的字符串拼接起来  
   - `标识符`: 如变量名，函数名等  

**ELF文件十六进制形式**:  
   - `输出命令`: `hd xxx.elf`  
   - `阅读方法`: <font color=purple>行首是偏移量</font>;其后<font color=purple>跟着的是16个字节，每个字节由2个十六进制数表示</font>; <font color=green>如0000 0000 ~ 0000 0001 就表示0000 0000那一排的前两个字节</font>    
   - `使用方法`: 查看`Section Headers`中的`.strtab`字符串表的偏移位置。到elf文件十六进制输出中，即可发现<font color=purple>符号表和字符串表之间的关系</font>  

### 实现
使用:`make run IMG=XXX`,需要给定IMG参数，然后就可以进行ftrace了  

