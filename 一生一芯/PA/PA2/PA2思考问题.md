# PA2
## RTFM - RTFSC(2)
**题目**:Motorola 68k系列的处理器都是大端架构的. 现在问题来了, 考虑以下两种情况:  
 - 假设我们需要将NEMU运行在Motorola 68k的机器上(把NEMU的源代码编译成Motorola 68k的机器码)  
 - 假设我们需要把Motorola 68k作为一个新的ISA加入到NEMU中  

在这两种情况下, 你需要注意些什么问题? 为什么会产生这些问题? 怎么解决它们?  


**解答**:  
> `注意`: 得到的指令将会和实际上的指令相反,nemu将无法正确识别指令  
> `产生的原因`: inst_fetch获取指令是根据小端来操作的  
> `解决`: 编写一个循环代码，将通过原本inst_fetch获得的指令进行倒序处理  

---
**题目**: mips32和riscv32的指令长度只有32位, 因此它们不能像x86那样, 把C代码中的32位常数直接编码到一条指令中.   
思考一下, mips32和riscv32应该如何解决这个问题?

**解答**: 暂时不会  

---

## 基础设施(2)
```
在Linux下编写一个Hello World程序, 然后使用strip命令丢弃可执行文件中的符号表:
gcc -o hello hello.c
strip -s hello
用readelf查看hello的信息, 你会发现符号表被丢弃了, 此时的hello程序能成功运行吗?

目标文件中也有符号表, 我们同样可以丢弃它:

gcc -c hello.c
strip -s hello.o
用readelf查看hello.o的信息, 你会发现符号表被丢弃了. 尝试对hello.o进行链接:
gcc -o hello hello.o
你发现了什么问题? 尝试对比上述两种情况, 并分析其中的原因.
```
**解答**: 
   - 情况1,可执行文件中的符号表是用来<font color=red>编译和链接过程中</font>对调试和符号解析的，不影响程序执行  
   - 情况2，链接器无法解析目标文件中的引用，导致链接失败  

---

**题目**:  为什么错误码是1呢? 你知道make程序是如何得到这个错误码的吗?  
**解答**: 原因是，作为配方的一部分调用的程序返回了非 0 错误代码（‘Error NN’），这使得 make 解释为失败，或者以其他异常方式退出（带有某种类型的信号”）

## 输入输出
![img](img/思考题-理解volatile关键字.png '思考题-理解volatile关键字 :size=50%')  
**解答**:  
1. `volatile的作用`: 修饰变量时，确保<font color=blue>每次访问</font>该变量时，<font color=red>都会生成指令</font>,**<font color=red>从内存中读取其值</font>**, 从而不会将其优化  
2. `去掉volatile带来的问题`: 会导致`访问该变量时`，<font color=blue>使用寄存器中的缓存值</font>.对于该段函数，就会生成一段死循环代码,没有循环后面的后续  

---
**问题**: 理解mainargs  
**解答**:  
1. 通过`a-m/scripts/platform/nemu.mk`中的`CFLAGS`引用  
```make
CFLAGS += -DMAINARGS=\"$(mainargs)\"
```





