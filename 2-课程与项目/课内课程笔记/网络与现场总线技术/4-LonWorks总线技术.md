# 第四章 LonWorks总线技术(都重要)
> :bulb:Neuron = 神经元

> :star: `LonWorks`<font color=red>被誉为通用控制网络</font>  

## 4.1 LonWorks总线概述
### 4.1.1 LonWorks总线技术的特点
- >网络协议开放，对任何用户平等  
- >可用任何介质进行通信,在同一网络中可以有多种通信介质  
- >`LonWorks总线技术`的<font color=purple>通信协议LonTalk</font>遵循了OSI参考模型协议，<font color=green>提供了OSI参考模型的所有的7层协议</font>    
- >`网络结构`: `主从式`、`对等式`或`客户/服务式`结构  
- >`网络拓扑`: `星状`、`总线`、`环状`及`自由结构`  
- >网络通信采用`面向对象`的设计方法,`LonWorks网络技术`被称为<font color=green>“网络变量“</font>  
- >通信的每帧有效字节数可为`0～228字节`  
- >通信速率: 1.25Mb/s-130m; 78kb/s-2700m  
 
- >**核心元件**: <font color=red>Neuron芯片</font>()  

---
### 4.1.2 LonWorks系统结构
LonWorks技术是集成`LON网络`的完整的开发平台  
- >`LON现场控制网络`: 包括`节点`、`通信介质`和`通信协议`  



**LonWorks技术组成**:  
- LonWorks节点和路由器  
   - >`LonWorks节点`: 核心技术采用了`神经元芯片`  
   - >`路由器`: LonWorks总线所特有的设备，使LON总线<font color=purple>突破传统的现场总线的限制</font>-<font color=green>不受通信介质、通信距离、通信速率的限制</font>  
- LonTalk协议  
   - >是一种`面向对象的`协议，支持OSI参考模型的<font color=green>7层协议</font>，具体<font color=green>实现形式是网络变量</font>  
- LonWorks收发器  
   - >包括`双绞线收发器`、`电力线收发器`、`无线收发器`、`光纤收发器`、`红外收发器`等多种，以适应多种介质的通信需要  
   - ><font color=blue>建立Neuron芯片与传输之间的物理连接</font>  
- LonWorks网络和节点开发工具

---
### 4.1.3 Neuron芯片及通信协议
LON网上的每个控制点被成为`LON节点`或`LonWorks智能设备`  

:star:LON节点组成: `Neuron芯片`，`传感器和控制设备`，`收发器(建立Neuron芯片与传输之间的物理连接)`和`电源`  

![img](img/典型的LON节点的方框图.png '图1 典型的LON节点的方框图. :size=50%')  

#### 1) Neuron芯片
**构成**:内部有3个`8位微处理器`,34种`I/O对象核定时器/计数器`，还有`LonTalk通信协议`  

#### 2) LonTalk协议
> :bulb: 是遵循OSI参考模式的<font color=purple>完整的7层协议</font>,且<font color=purple>支持多种通信介质</font>  

:star:**LonTalk寻址体系**: 由三级构成  
- >`最高级`: 域(Domain) - 只有<font color=green>在<u>同一个域</u>中的节点<u>才能相互通信</u></font>  
- >`第二级`: 子网(Subnet) - 每个域可以有<font color=green>255个子网</font>  
- >`第三级`: 节点(Node) - 每个子网可以有<font color=green>127个节点</font>，节点<font color=purple>可编成组(可以是不同子网的节点),一个域内可有256个组</font>  


:star:**LonTalk协议的四种消息服务类型**: `应答(ACKD)`,`请求/响应(REQUEST)`, `非应答式重发(UNACKD-RPT)`,`非应答式(UNACKD)`  

---
#### 3) 网络变量及显示消息
(填空):LonTalk协议的<font color=green>表示层</font>中的数据被称为<font color=green>网络变量</font>  


## 4.2 LonWorks节点
**LonWorks节点有两种基本组成类型**:   
- > `基于Neuron芯片的节点`:将Neuron芯片作为节点中唯一的处理器  
- > `基于主机的节点`: 将Neuron节点作为节点的通信处理器，用高级主机的资源完成复杂的测控功能  

**LonWorks节点的基本组成**: <font color=red>都有一个神经元芯片用于通信和控制，一个I/O接口用于连接I/O设备，一个收发器负责将节点连接上网</font>  

![img](img/LonWorks节点的两种基本组成类型的结构.png '图2 LonWorks节点的两种基本组成类型的结构. :size=50%')  

![img](img/基于神经元芯片节点的结构框图.png '图3 基于神经元芯片节点的结构框图 :size=50%')  

![img](img/基于主机节点的结构框图.png '图4 基于主机节点的结构框图 :size=50%')  

### 路由器
**路由**: 可以使信息最快、最方便到达目标节点的那条线路  

**路由器**:  
- > 工作在<font color=red>网络层</font>  
- > `功能`: <font color=green>用于完成网络层设备的连接，并可用于互联不同类型的网络</font>  
- > `类型`: `中继器`，`网桥`，`学习路由器`  

---

## 4.3 Neuron芯片的CPU结构(重点)
**Neuron芯片内部有三个CPU**:  
- >`MAC CPU`: 介质访问控制处理器，<font color=red>处理LonTalk协议的第1层和第2层</font>  
- >`网络CPU`: 处理网络变量、寻址、事务处理等,<font color=red>实现LonTalk协议的第3～第6层</font>  
- >`应用CPU`: 完成用户的编程,<font color=red>实现LonTalk协议的第7层</font>    

![img](img/LonTalk协议层.png '图5 LonTalk协议层 :size=50%')  

---
## 4.6 面向对象的编程语言-Neuron C
**重要语法**:  
- `when`: 引入时间，并<font color=green>定义这些时间的当前时间顺序</font>，<font color=red>调度程序会循环往复的运行when子句</font>  
   - >可以<font color=purple>一个</font>when子句与`一个任务`相关联  
   - >可以<font color=purple>多个</font>when子句与`一个任务`发生关联  

```c
// when子句语法
[priority] [preempt_safe] when(event) 
{
   task;
}
```
- `priority`: 调度程序会<font color=red>优先判断</font>优先级高的`when子句`  
- `event`: 事件，当其为`TRUE`时，则会执行when子句中的`task`  
   - >`预定事件`: 用已经设置完整的<font color=red>关键字实现</font>相应的功能  
   - >`用户自定义事件`: 任意<font color=red>有效的Neuron C表达式</font>  

|  关键字                |    含义                                             |
| -------------          |-------------                                        |
|   reset                |       节点已经被启动                                |
|   offline              |       节点被置为脱机                                |
|   online               |       节点被置为联机                                |
|   fflush_completes     |       节点已做好睡眠模式的准备                      |
|   Wink                 |       节点已收到Wink网络管理报文                    |
|   io_changes           |       I/O对象值被改变                               |
|   io_in_ready          |       并行I/O对象准备好接受来自外部的CPU数据        |
|   io_out_ready         |       并行I/O对象准备好发送数据至外部的CPU          |
|   io_update_occurs     |       定时器/计数器的值已经更新                     |
|   timer_expires        |       软件定时器的值已经为0                         |


---
**实例**:
```c
//实例1
When(timer-expires(led-timer)) {
   io_out (io_led, OFF);
}

//实例2
When (reset)
When (io_changes(io_switch))
When (! Timer_expires)
When (fflush_completes && (y == 5))
When (x == 3)
{
   ...
}

```







