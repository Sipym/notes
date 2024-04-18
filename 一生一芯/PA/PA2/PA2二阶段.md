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

---

**PA的流程**:
```text
(在NEMU中)实现硬件功能 -> (在AM中)提供运行时环境 -> (在APP层)运行程序
(在NEMU中)实现更强大的硬件功能 -> (在AM中)提供更丰富的运行时环境 -> (在APP层)运行更复杂的程序
```
