# 概念,问题解答,一些定义含义
## 客户程序
客户程序是与ISA相关的.  
`内置客户程序`放在`nemu/src/isa/$isa/init.c`中

## 内存
可以看作一段连续的存储空间  
NEMU默认为客户计算机提供128MB的物理内存(见`nemu/src/memory/paddr.c`中定义的大数组`pmem`)  

在客户程序运行的过程中，总是使用`vaddr_read()`和`vaddr_write()`(在`nemu/src/memory/vaddr.c`中定义)来访问`模拟的内存`。  
vaddr,paddr分别代表虚拟地址和物理地址  


## 客户程序应读入到内存的什么位置？
要让客户机算计的CPU可以执行客户程序,需要让CPU知道客户程序的位置  
采用最简单的一种方式:`约定`来实现  
> 即让`monitor`直接把客户程序读入到一个固定的内存位置`RESET_VECTOR`,`RESET_VECTOR`的值在`nemu/include/memory/paddr.h`中定义  

## BIOS
是固化在ROM/Flash(都是非易失性的存储介质)中的,BIOS中的内容不会因为断电而丢失  

因此在真实的计算机系统中, 计算机启动后首先会把控制权交给BIOS, BIOS经过一系列初始化工作之后, 再从磁盘中将有意义的程序读入内存中执行.  

<font color=purple>在PA中,采用`约定`的方式让CPU直接从约定的内存位置开始执行</font>  

## CONFIG_MBASE
是内存的起始地址  
对于mips32和riscv32的物理地址均从`0x80000000`开始,因此对于这两个的`CONFIG_MBASE`会被定义为`0x80000000`  
将来CPU访问内存时, 我们会将CPU将要访问的内存地址映射到`pmem`中的相应偏移位置, 这是通过`nemu/src/memory/paddr.c`中的`guest_to_host()`函数实现的.  
> 例如如果mips32的CPU打算访问内存地址0x80000000, 我们会让它最终访问`pmem[0]`, 从而可以正确访问客户程序的第一条指令. 这种机制有一个专门的名字, 叫地址映射  


## 用于测试的宏
在`nemu/include/macro.h`中定义来一些专门用来对宏进行测试的宏。  
> `IFDEF(CONFIG_DEVICE,init_device());`表示，如果定义了CONFIG_DEVICE，才会调用`init_device()`函数  
> `MUXDEF(CONFIG_TRACE, "ON","OFF")`表示，如果定义来`CONFIG_TRACE`,则预处理结果为"ON"，否则为"OFF"  
>> 原理看macro.h里的宏定义就行了  
