# AM - 裸机运行时环境
**概念**: 按照计算机发展史 将`计算机功能`<font color=red>抽象</font>的<font color=purple>模块化</font>的<font color=red>裸机运行时环境</font>  
## 抽象
**概念**: 引入一个抽象层，将这些机制的功能抽象成API  
**功能**: 程序只需要调用这些API,就`可以使用相应的机制`,而<font color=purple>无需了解这些机制的细节</font>  

**<font color=purple>这套API的名字，叫Abstract Machine(AM)</font>**$\uparrow$  
## AM根据程序需求把分成以下模块
- `TRM(Turing Maching)` - 图灵机，最简单的运行时环境，<font color=sky_blue>为程序提供基本的计算能力</font>  
- `IOE(I/O Extension)` - 输入输出扩展，<font color=sky_blue>为程序提供输出出入的能力</font>  
- `CTE(Context Extension)` - 上下文扩展，<font color=sky_blue>为程序提供上下文管理的能力</font>  
- `VME(Virtual Memory Extension)` - 虚存扩展，<font color=sky_blue>为程序提供虚存管理的能力</font>  
- `MPE(Multi-Processor Extension)` - 多处理器扩展，<font color=sky_blue>为程序提供多处理器通信的能力</font>  

### TRM
**运行时环境(AM)需要提供**:
- 可以用来自由计算的内存区间 - 堆区  
- 程序"入口"-`main(const char *args)`  
- 退出程序的方式`halt()`  
- 打印字符`putch()`  

### IOE-输入输出
**运行时环境(AM)需要提供**:
- 需要输入函数`ioe_read()`,输出函数`ioe_write()`  
- 一些约定的，与系统无关的抽象设备  
   - 如时钟，键盘，2D GPU[串口，声卡，磁盘，网卡]  

> 得到了一个冯诺伊曼计算机系统  

### CTE-上下文管理
进行中断/异常处理，**运行时环境(AM)需要提供**:
- 上下文保存/恢复  
- 事件处理回调函数  
- `kcontext()`创建内核上下文  
- `yield()`自陷操作  
- `ienabled()`/`iset()`中断查询/设置  

> 得到了一个批处理系统  


### VME和MPE - 虚存管理和多处理器
VME**运行时环境(AM)需要提供**:
- `protect()`创建虚拟地址空间  
- `map()`添加va到pa的映射关系  
- `ucontext()`创建用户上下文  


## AM的设计原则和取舍
**KISS原则**: 提供<font color=red>最少的API</font>来实现现代化计算机系统软件  

## AM的意义
1. 模块化使得计算机可以`按需组合`  
   - [选项1] 程序要(高效的)计算 -> (支持指令集的)图灵机[TRM] {必选}  
   - [选项2] 程序要输入输出 -> 冯诺伊曼[IOE]  
   - [选项3] 想依次运行多个程序 -> 批处理系统[CTE]  
   - [选项4] 想并发运行多个程序 -> 分时多任务[VME]  
   - [选项5] 想并行运行多个程序 -> 多处理器系统[MPE]  

2. 思想和RISC-V模块化的指令集扩展类似  
3. <font color=red>先完成，后完美</font>  

4. 抽象，支持各种计算机和程序  

# nemu运行am-kernels提供的客户程序
**要求**:将客户程序`根据AM的运行时环境`编译成能够在`$ISA-nemu`这个新环境运行的`可执行文件`  
   - 提供描述`$ISA-nemu`的运行时环境的链接脚本  

> 编译和链接选项位于`abstract-machine/Makefile`,和`abstract-machine/scripts/`下的相关`.mk`文件中  

## nemu在运行时环境运行程序的过程
1. gcc将`$ISA-nemu`的AM实现源文件编译成目标文件，通过`ar`将这些目标文件作为一个库,打包成一个<font color=purple>归档文件</font>`abstract-machine/am/build/am-$ISA-nemu.a`  
2. gcc将`应用程序源文件`(如`am-kernels/tests/cpu-tests/tests/dummy.c`编译成目标文件  
3. 通过gcc和ar吧程序依赖的运行库(如`abstract-machine/klib/`)也编译<font color=purple>打包成归档文件</font>  
4. 根据`abstract-machine/scripts/$ISA-nemu.mk`的指示，让ld根据链接脚本`abstract-machine/scripts/linker.ld`，将上述目标文件和归档文件链接成可执行文件   

###<font color=red>具体实现过程</font> 
1. 在`am-kernels/tests/cpu-tests/`运行`make ARCH=riscv64-nemu ALL=要编译的程序`,可得到目标文件  
2. 我要用的是riscv64的架构，链接时，需要使用相关的gnu工具,即`riscv64-linux-gnu-XXX`  
3. 在`AM_HOME/scripts/riscv64-nemu.mk`中 **<font color=sky_blue>建立链接规则</font>**  
4. 在`AM_HOME/klib`下运行`make ARCH=riscv64-nemu ld`即可生成可执行文件  

## 编译得到的可执行文件的行为
1. 第一条指令从`abstract-machine/am/src/$ISA/nemu/start.S`开始，设置后栈顶后跳转到`abstract-machine/am/src/platform/nemu/trm.c`的`_trm_init()`函数处执行  
2. `_trm_init()`调用`main()`函数执行程序的主体功能，`main()`还带一个参数   
3. 从`main()`返回后，调用`halt()`结束运行


# 实现常用的库函数
**实现路径**:`abstract-machine/klib/`  
   - 用于收录与架构无关的运行时环境(如这些常用的库函数,`memcpy()`)  

**要实现的库函数**:见`abstract-machine/klib/src/string.c`和`abstract-machine/klib/src/stdio.c`  

## 如何验证
### 单独验证库函数的实现
1. 通过架构`native`来运行  
2. 打开`abstract-machine/klib/include/klib.h`中的宏定义`__NATIVE_USE_KLIB` 来吧<font color=purple>库函数链接到klib</font>,而不是使用glib  
3. 在`cpu_test`运行即可`make ARCH=native ALL=string run`  

### 在nemu上验证







