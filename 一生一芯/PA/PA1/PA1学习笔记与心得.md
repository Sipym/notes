# 最简单的计算机(被称为图灵机TRM)
- `结构`: 存储器, PC, 寄存器, 加法器  
- `工作方式`: 不断地重复以下过程: 从PC指示的存储器位置<font color=purple>取出指令</font>, <font color=purple>执行指令</font>, 然后<font color=purple>更新PC</font>  

## 计算机的重要结构组成
|  结构 |  功能  |
|  ----  |  ----  |
| 存储器 | 用来存储程序 |
| CPU | 负责处理数据的核心电路单元 |
| 运算器 | 对数据进行各种处理 |
| 寄存器 | 将CPU正在处理的数据暂存在其中,<font color=red>寄存器的速度很快，但容量很小</font> |
| 指令 | 用来指示CPU对数据进行何种处理 |
| 程序计数器PC(x86中,叫`EIP`) | 程序计数器，可以让CPU知道现在执行导那一条指令了 |

## TRM的工作方式
不断地重复以下过程: 从PC指示的存储器位置取出指令, 执行指令, 然后更新PC  
``` c
while (1) {
  从PC指示的存储器位置取出指令;
  执行指令;
  更新PC;
}
```
TRM的工作方式通过`cpu_exec()`和`exec_once()`体现  

# 计算机是一个状态机  
把计算机划分成两部分, 一部分由所有时序逻辑部件(存储器, 计数器, 寄存器)构成, 另一部分则是剩余的组合逻辑部件(如加法器等)  
<font color=purple>工作过程</font>: 每个时钟周期到来的时候, 计算机根据当前时序逻辑部件的状态, 在组合逻辑部件的作用下, 计算出并转移到下一时钟周期的新状态.  

## 程序是个状态机
在状态机模型中，`指令`可以堪称计算机进行一次状态转移的`输入激励`.  
给定一个程序，把它放到计算机的内存中，就相当于在`状态数量N`的状态转换图中<font color=purple>指定来一个初始状态</font>,程序`运行的过程`就是从这个初始状态开始，每执行完一条指令<font color=purple>就会进行一次确定的状态转移.</font>所以程序也可以看成一个状态机！这个状态机是上文提到的大状态机(状态数量为N)的子集。  


# :star:NEMU
一款经过简化的计算机系统模拟器,被称为`客户计算机`  

## nemu组成
`组成(四个模块)`: monitor监视器,CPU，memory，设备  
- `Monitor(监视器)`:方便地监控客户计算机的运行状态。负责与GNU/Linux进行交互;<font color=purple>具有调试器的功能</font>  
   - 概念上并不属于计算机的必要组成部分，但是NEMU必要的基础设施  

## nemu 配置系统和项目构建
[参考链接](https://ysyx.oscc.cc/docs/ics-pa/1.3.html#%E9%85%8D%E7%BD%AE%E7%B3%BB%E7%BB%9F%E5%92%8C%E9%A1%B9%E7%9B%AE%E6%9E%84%E5%BB%BA)
### 配置系统kconfig - 管理形如`CONFIG_xxx`的宏定义
<font color=blue>源文件</font>:`nemu/tools/kconfig`  
<font color=blue>编写</font>: 使用如下语言来编写"配置描述文件"  
   - 配置选项的属性, 包括类型, 默认值等  
   - 不同配置选项之间的关系  
   - 配置选项的层次关系  

<font color=blue>运行</font>:`make menuconfig`  

<font color=blue>当前配置系统的配置</font>:  
   - `nemu/include/generated/autoconf.h`, 定义一些形如`CONFIG_xxx`的宏，可以**在c代码中通过条件编译的功能对这些宏进行测试，来判断是否编译某些代码**。  
   - `nemu/include/config/auto.conf`, 阅读Makefile时使用  

### 文件列表: 决定最终参与编译的源文件
根据`menuconfig`的配置对`nemu/src/filelist.mk`中的变量进行维护  
   - `SRCS-y` - 参与编译的源文件的候选集合
   - `SRCS-BLACKLIST-y` - 不参与编译的源文件的黑名单集合
   - `DIRS-y` - 参与编译的目录集合, 该目录下的所有文件都会被加入到SRCS-y中
   - `DIRS-BLACKLIST-y` - 不参与编译的目录集合, 该目录下的所有文件都会被加入到SRCS-BLACKLIST-y中


## 准备第一个客户程序
> <font color=red>NEMU是一个用来执行客户程序的程序</font>  

> tip: `init_monitor`解读见`../NEMU详细解读.md`  

首先需要将`客户程序`读入到客户计算机中,这件事<font size=5>由monitor负责</font>  
在NEMU开始运行时，首先会调用`init_monitor()`函数来进行一些和monitor相关的初始化工作。  





