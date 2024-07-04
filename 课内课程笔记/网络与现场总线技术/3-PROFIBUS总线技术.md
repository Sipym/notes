# 第三章 PROFIBUS总线技术
## 3.1 PROFIBUS基本特性(<font color=red>掌握三种的分类,区别,联系</font>)
> PROFIBUS分系统分为主站和从站,主站决定总线的数据通信，当主站得到总线控制权(令牌)时，没有外界请求也可以主动发送信息  

### 1.协议结构
![img](img/PROFIBUS协议结构.png '图1 PROFIBUS协议结构 :size=70%')  
- >`PROFIBUS-FMS`: 定义了1,2,7层，应用层包括现场总线报文规范(FMS)和底层接口(LLI)  
- >`PROFIBUS_DP`: 定义了1,2层和用户接口，用户接口规定了用户和系统以及不同设备可调用的应用功能  
- >`PROFIBUS-PA`: 扩展的PROFIBUS-DP协议  


---
### 2. PROFIBUS物理层用到的传输技术
**RS-485传输技术**: 满足了数据和电源的传送必须在同一根电缆的需求  
- >`通称`: H2  
- >`构成`: 屏蔽双绞同轴电缆  
- >`传输速度`: 与电缆最大长度相关，可选$9.6kb/s$ ~ $12mb/s$  

**IEC1158-2传输技术**: 满足化工和石化工业的要求，可保持其本质安全性，现有设备通过总线供电  
- >`通称`: H1  
- >`传输速度`:$31.25kb/s$  

**光纤传输技术**: <font color=green>用于电磁干扰很大的环境</font>,可以用光纤导体延长高速传输的最大距离  

---
### 3. 总线协议(<font color=grey>不重要</font>)
**PROFIBUS总线仲裁协议**: 在OSI参考模型<font color=purple>第二层实现</font>，确保<font color=green>任何时刻只能有一个站点发送数据</font>  

**PROFIBUS总线存取协议**: 在OSI参考模型<font color=purple>第二层实现</font>,包括主站之间的`令牌传递方式`和主站与从站之间的`主从传递方式`  
- >`令牌传递方式`: 通过`令牌传递程序`保证了每个主站在<font color=green>一个确切规定的时间框内</font><font color=purple>获得总线存取权</font>(令牌)  
- >`主从传递方式`: 主站`得到令牌`后，可与`从站通信`，可以向从站发送或索取信息，亦可`和其他主站通信`  

---


## 3.2 PROFIBUS总线(只写了行规)
> 根据`应用特点`分为`PROFIBUS-FMS`,`PROFIBUS-DP`,`PROFIBUS-PA`  

### 3.2.1 PROFIBUS-FMS
**用途**: <font color=red>解决车间级的通用性通信任务</font>，提供大量的通信服务，完成中等传输速度的循环和非循环通信任务  

:star:**<font color=red>行规</font>**:star::  
- >`控制器间通信`: 定义了用于PLC控制器之间通信的PROFIBUS-FMS服务。根据控制器的等级对每个PLC必须支持的服务、参数和数据类型做了规定  
- >`楼宇自动化行规`: 用于提供特定的分类和服务作为楼宇自动化的公共基础  
- >`低压开关设备`: 规定了通过PROFIBUS-FMS通信过程中低压开关设备的应用行为  

### 3.2.2 PROFIBUS-DP
**用途**: 用于设备级的<font color=red>高速数据传送</font>，`中央控制器`通过高速串行线<font color=purple>同分散的现场设备进行通信</font>  

:star:**<font color=red>行规</font>**:star::  
- >`NC/RC行规`: 描述如何通过PROFIBUS-DP对操作机器人和装配机器人进行控制  
- >`编码器行规`:  
- >`变速传动行规`:  
- >`操作员控制和过程监视行规`:  

### 3.2.3 PROFIBUS-PA
**用途**: 解决过程自动化控制中大量的<font color=red>要求本质安全通信传输</font>的问题  

:star:**<font color=red>行规</font>**:star:: 书上没写  

## 3.3 PROFIBUS与ISO/OSI参考模型(<font color=red>重点</font>)
![img](img/OSI参考模型与PROFIBUS体系结构的对比.png '图2 OSI参考模型与PROFIBUS体系结构的对比. :size=70%')  

:star:PROFIBUS: 用到了1,2,7层  


## 3.5 PROFIBUS 控制系统集成技术
### 3.5.1 PROFIBUS控制系统的组成(重点)
1. **一类主站**:  
   - >`构成`: `PC`,`PLC`或可作一类主站的`控制器`  
   - >`功能`: 一类主站完成<font color=red>总线通信控制与管理</font>  
2. **二类主站**:  
   - >`构成`: 操作员工作站、编程器、操作员接口等  
   - >`功能`: 完成各站点的<font color=red>数据读写、系统配置、故障诊断等</font>  
3. **从站**:  
   1. >`PLC(智能型I/O)`:   
   2. >`分散式I/O`  
   3. >`驱动器、传感器执行机构等现场设备`  












