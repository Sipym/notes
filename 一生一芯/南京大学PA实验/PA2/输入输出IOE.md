# IOE - 输入输出
输入输出的`实现`: 通过访问I/O设备  
### 设备
**设备**: 也是个数字电路,有自己的`状态寄存器`，`功能部件`  
**命令字**: `控制设备工作`的信号,理解成"设备的指令"  
**设备的工作流程**:<font color=purple>同CPU</font>,接受命令字，译码，执行....  

> (<font color=purple>程序视角</font>)**访问设备** = 读出数据 + 写入数据 + 控制状态  

--- 

设备与CPU的接口: 设备的寄存器(或内存，如DRAM)  

## 编址方式
### 端口映射I/O(PIO)
*特点*:端口映射I/O把端口号作为I/O指令的一部分  
*缺点*: 端口映射I/O能访问的I/O地址空间大小，在设计指令的那一刻就已经决定下来了  


### 内存映射I/O (memory-mapped I/O -- MMIO)
**定义**: 通过`物理内存`给设备编址，通过重定向到I/O地址空间  
**实例说明**: NEMU中的物理地址区间`[0xa1000000,0xa18000000)`,这段物理地址区间被<font color=red>映射到VGA内部的显存</font>，<font color=blue>读写这段物理地址区间就相当于读写VGA显存的数据</font>    


## NEMU中的输入输出(重点)
### 映射和I/O方式
在`$NEMU_HOME/src/device`中有定义  

### NEMU中的设备
NEMU实现了串口, 时钟, 键盘, VGA, 声卡, 磁盘, SD卡七种设备  

`init_device`:  
1. 调用`init_map()`进行初始化  
2. 对上述设备进行初始化  
3. 进行定时器相关的初始化工作(PA4用到)  

`device_update()`:  
1. `cpu_exec()`在没执行完一条指令后，就会调用该函数  
2. 检查距离上次设备更新是否超过一定时间，若是，则刷新屏幕  
3. 检查<font color=red>是否有按键按下/释放</font>  
4. ...

###<font color=red>NEMU实现IOE的具体原理</font> 
**设备初始化**:  调用`init_device()`函数: 初始化map,初始化各个设备  
   - `map`: <font color=red>用于存放设备寄存器的数据</font>  
   - 利用`new_space()`为设备分配空间，可以通过设备基地址(如`serial_base`,<font color=red>访问串行设备的寄存器</font>)  
      - >*原理*:每分配一个space,都会使pspace递增，直到`p_space-io_space > io_space_max`时，将不再能分配  
   - `选择映射方式`(一般为内存映射MMIO),调用`add_mmio_map()`<font color=blue>创建设备映射$maps$</font>   



**访问设备具体是如何实现的**: <font color=brown>实现方式是根据特定架构实现的</font>  
1. **c程序访问设备**: 通过调用`am/src/riscv/riscv.h`中的函数`inb,outb,...`  
   - 实现原理: 利用`valatile`修饰地址，编译器编译`地址变量时`，将不会对其优化，而会<font color=red>每次都访问内存</font>，更新它的值  
      - > 具体就相当于会把上述函数<font color=green>翻译成: `load,store`指令类型</font>  
2. 而store,load等指令，则是通过`paddr_read,paddr_write`实现  
3. 以`padd_read`为例:  
   - 首先判断`addr`是否属于物理地址区域,如果是，则调用`pmem_read()`访问内存  
   - 如果不是，调用`mmio_read()`  
      - 调用`fetch_mmio_map(addr)`来判断地址`属于哪个设备`或者`不属于任何设备(NULL)`  
      - 调用`map_read()`来读取设备数据  
         - <font color=red>具体读取方式，看各个设备的`callback函数`,如`serial_io_handler()`</font>  


### 将输入输出抽象成IOE
**意义**: 是与架构无关的，可以抽象出来  
```c
// IOE的三个API
bool ioe_init();
void ioe_read(int reg, void *buf);
void ioe_write(int reg, void *buf);
```
`reg`寄存器:  
   - > *含义*: 是一个功能编号，`不同架构`中，`同一个功能编号`的<font color=red>含义是相同</font>的  
   - > tip: <font color=purple>不是设备寄存器</font>，<font color=red>设备寄存器的编号是架构相关的</font>  
   - > *定义位置*: `abstract-machine/am/include/amdev.h`，<font color=red>是架构无关的</font>  

**实战**:  
1. 在通用文件`am/inclue/am.h`中抽象出这三个API  
2. 具体实现在`特定架构的ioe.c`中,如`am/platform/nemu/ioe/ioe.c`  
   - 看特定架构的ioe.c就知道其实现原理了  

**<font color=blue>ioe_init() 实现分析</font>**:  
1. 首先在`am/am.h`中声明  
2. 不同架构不同实现，以`nemu`实现为例  
   1. `ioe_read(AM_TIMER_UPTIME,&AM_TIMER_UPTIME_T)`，将会被翻译成  
   2. `__amtimer_uptime(&AM_TIMER_UPTIME_T)`  
3. 因此，<font color=red>要实现`ioe_read()`,首先需要实现各个`am_...()`函数</font>  
   - > 实现方式，就可以参考上面那一小节的原理介绍  

### 键盘IOE的实现原理
在am/src/platform/nemu/ioe/input.c中提供了注释


### 设备-VGA
用到的<font color=purple>抽象寄存器</font>:  
- `AM_GPU_CONFIG`: AM显示控制器信息，可以<font color=green>读出屏幕大小信息</font>`width`和`height`.AM假设在运行过程中，屏幕大小不会发生变化  
- `AM_GPU_FBDRAW`: AM帧缓冲控制器，可写入绘图信息。向屏幕`(x,y)`坐标处绘制`w*h`的矩形图像  
   - 图像像素按行有限方式存储在`pixels`中，每个像素用32位证书以`00RRGGBB`方式描述颜色  
   - `sync == true`时，马上将帧缓冲的内容同步到屏幕上  

---
## 设备与difftest
由于NEMU中设备的`行为是我们自定义`的, 与REF中的标准设备的`行为不完全一样` (例如NEMU中的串口总是就绪的, 但QEMU中的串口也许并不是这样), 这<font color=purple>导致在NEMU中执行输入指令的结果会和REF有所不同</font>  

**使Difftest能正常工作**: 调用`difftest_skip_ref`函数,跳过与REF的检查  




