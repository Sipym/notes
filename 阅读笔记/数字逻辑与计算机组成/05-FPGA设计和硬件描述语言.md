# 可编程逻辑器件和FPGA设计
## 可编程逻辑器件PLD
![img](img/PLD结构框图.png '图1 PLD结构框图 :size=80%')  
**功能**: 可根据需要进行编程以构成不同功能的逻辑电路  
![img](img/PLD中常用基本符号表示.png '图2 PLD中常用基本符号表示 :size=100%')  

**PLD分类**:   
   - *简单PLD*: 指逻辑们数在500门以下，包括`PROM`、`PLA`、`PAL`、`GAL`等器件  
      - > 通常用于实现规模较小的数字电路
   - *复杂PLD*: 指芯片集成度,逻辑门数500门以上，包括`EPLD`、<font color=purple>GPLD</font>、<font color=purple>FPGA</font>等期间  

### PROM结构
![img](img/PROM结构示意图.png '图3 PROM结构示意图 :size=100%')  
**可编程只读存储器(Programmable Read Only Memory,PROM)**: 一种`与阵列固定`、`或阵列可编程`的简单PLD  
**功能**: 任何逻辑函数转换为<font color=red>标准与-或表达式</font>后，均可以用PROM表示  

### PLA结构
![img](img/PLA结构示意图.png '图4 PLA结构示意图 :size=100%')  
**可编程逻辑阵列(Programmable Logic Array,PLA)**: 是`与阵列可编程`，`或阵列可编程`的逻辑阵列  
**功能**: 将逻辑函数化简为<font color=blue>最简与-或表达式</font>既可以用PLA表示  

### PAL结构
![img](img/PAL结构示意图.png '图5 PAL结构示意图 :size=100%')  
**可编程阵列逻辑(Programmable Array Logic,PAL)**: 是`与阵列可编程`，`或阵列固定`的逻辑阵列  

### GAL结构
**通用阵列逻辑(Genetic Array Logic, GAL)**: 输出结构可以有用户定义的可编程输出结构  

### GPLD结构(复杂PLD)
**复杂可编程逻辑器件(Complex Programmable Logic Device, GPLD)**
**组成**: 多个`逻辑阵列块(Logic Array Block,LAB)`、`I/O控制块`和`可编程互连阵列(PIA)`  
   - `LAB`: 由4~20个`宏单元`组成,每个宏单元有多种配置方式，也可级联使用  
   - `I/O控制块`: 用于<font color=purple>和芯片的输入/输出引脚相连</font>  
   - `可编程互连阵列`: <font color=purple>连接所有宏单元</font>，并通过专用连线与芯片的时钟、复位和使能等引脚相连  

**宏单元**: GPLD的基本结构,相当于一个类似PAL的电路模块，用于实现基本的逻辑功能  
**宏单元组成**: 可编程逻辑阵列，乘积项选择矩阵，可编程寄存器(通过编程实现触发器)  


## 存储器阵列
![img](img/存储器阵列示意图.png '图6 存储器阵列示意图 :size=100%')  
**构成**: 每行为一个存储单元(存储元)，存储一个字。阵列的宽度就是数据的位数  
**容量**: $2^n\text{字} \times m\text{位}$,可简写为$2^n\times m$  
**分类**: 随机存取存储器(Random Access Memory,`RAM`),只读存储器(Read Only Memory,`ROM`)  

### 静态RAM存储元件
![img](img/SRAM6管静态存储元件.png '图7 SRAM 6管静态存储元件 :size=100%')  

**结构组成**: $T_1,T_2$构成触发器,$T_5,T_6$是触发器的负载管,$T_3,T_4$为门控管  

**"0"状态定义**: $T_1$导通,$T_2$截止,此时A为低电平，B位高电平  
**"1"状态定义**: $T_2$导通,$T_1$截止,此时B为低电平，A位高电平  

**<font color=red>写操作</font>**: 字选择线W加高电平 **=>** $T_3,T_4$导通  
   - `写"1"`: 位线$D_0,D_1$分别加高、低电平 **=>** 使得T_2导通,T_1截止  
   - `写"0"`: 位线$D_0,D_1$分别加低、高电平 **=>** 使得T_1导通,T_2截止  

**保持不变**: 字选择线W加低电平,$T_3,T_4$截止,触发器与外界隔离  

**<font color=red>读操作</font>**: 先在两个位线上加高电平, 再字选择线W加上高电平  
   - `读取结果判断`: 根据哪条位线上有负脉冲可区分读出的是"0"还是"1"  
   - `读"1"`: 一开始T_2导通,T_1截止.位线加高电平后,$D_1,T_4,T_2,GND$之间有电流通过，及产生了一个负脉冲  
   - `读"0"`: 一开始T_1导通,T_2截止.位线加高电平后,$D_0,T_3,T_1,GND$之间有电流通过，及产生了一个负脉冲  

**优点**: <font color=red>无须刷新，读后再生</font>。读写速度快  
**缺点**: MOS管多，占硅片面积大.因而价格高、功耗大、集成度低  
> **功耗大**: 当存储元件不工作时，也有电流流过,所以功耗大  

### 动态RAM存储元件
![img](img/DRAM-单管动态存储原价.png '图8 DRAM-单管动态存储元件. :size=100%')  
**写"1"**: 在数据线上加高电平,经T对$C_s$充电  
**写"0"**: 在数据线上加低电平,$C_s$充分放电使其上无电荷  
**读"1"**: 读取时,$C_s$上电荷放电  
**读"0"**: 读取时,$C_s$上无电荷,即没有电流产生  

> :bulb:<font color=purple>动态RAM读操作是破坏性读出，读后应有重写操作</font>,称为**再生**  

> :bulb: <font color=purple>电容上存储的电荷会缓缓放电，超过一定时间，就会丢失信息</font>，因此必须定是给电容充电，称为**再生**

**优点**: MOS管小，占硅片面积小，因而价格便宜、功耗小、集成度高  
**缺点**: 必须定时刷新和读后再生，读写速度相对较慢  


### ROM
**类别**: MROM,PROM,EPROM,EEPROM(E2PROM)等类型  
   - `掩膜制度存储器(MROM)`: 存储的信息由厂家在掩膜工艺过程中写入，用户不能修改  
   - `可编程只读存储器(PROM)`: 用户可用专门的PROM写入器将信息写入，写入不可逆  
   - `可擦除可编程只读存储器(EPROM)`: 允许通过某种编辑器向ROM芯片中写入信息，并可擦除所有信息后重新写入，可反复擦除-写入多次  
   - `电擦除电改写制度存储器(EEPROM)`: 读数据同EPROM,可以用电来擦除和重新编程，<font color=red>可以选择只删除个别字</font>,市面上的U盘即是用的EEPROM作为存储截止  

## FPGA设计概述
**现场可编程门阵列(Field Programmable Gate Array,FPGA)**: 可通过软件对其进行配置和编程，并可反复擦写  
**FPGA技术实现**: 都是基于`查找表(Look-Up Table,LUT)`技术构建的  
**FPGA使用流程**: 设计者通过`逻辑电路图`或`硬件描述语言(HDL)`描述逻辑电路后，<font color=purple>EDA工具</font>自动将逻辑电路<font color=purple>转换为真值表</font>，通过对FPGA器件的编程，将真值表的结果加载到用作LUT的SRAM单元中  
**<font color=purple>组成</font>**: 包含大量的逻辑单元,每个逻辑单元有若干查找表，多路选择器，进位链，触发器等附加逻辑组成  
![img](img/最简单的FPGA逻辑单元结构示意图.png '图9 最简单的FPGA逻辑单元结构示意图 :size=100%')  

### 查找表(LUT)
**组成**: 本质是一个RAM,大部分采用SRAM实现  
**功能**: 可以实现任何逻辑功能,通常用于<font color=purple>实现一个小规模的逻辑函数</font>  
**原理**: 根据要实现的逻辑函数的真值表,将输出值存到LUT(即RAM)中,根据输入A,B,C,...即可对应相应的输出值，这就实现了逻辑函数  
![img](img/四输入LUT结构.png '图10 四输入LUT结构 :size=100%')  


## 专用集成电路
**专用集成电路(Application-Specific Integrated Circuit,ASIC)**: 应特定用户要求和特定电子系统的需要而设计、制造的集成电路  
**分类**:  
   - `全定制`: 需要设计者完成所有电路的设计  
   - `半定制`: 使用标准库里的标准逻辑单元进行设计  


# HDL概述
硬件描述语言是一种用形式化方法来描述数字电路和设计逻辑系统的语言  

## VHDL和Verilog HDL介绍
**共同特点**: 
   - 能形式化地抽象表示电路的结构和行为;  
   - 支持逻辑设计中层次和领域的描述;  
   - 可借用高级语言的精巧结构来简化电路行为的描述,具有电路仿真与验证机制以保证设计的正确性;  
   - 支持电路描述从高曾到低层的综合转换;  
   - 硬件描述与实现工艺无关;便于文档管理;  

**Verilog HDL**: (推荐)  
   - `优点`: 门级开关电路描述方面比VHDL強得多,易于学习和掌握  

**VHDL**:   
   - `优点`: 系统级抽象方面更好  

## 基于HDL的数字电路设计流程
### 第一步 HDL编码
根据目标电路的设计需求进行编码  

### 第二步 仿真
**方式1**: 利用`测试激励`(对待测试模块提供输入的模块)  
**方式2**: 利用c语言程序  

### 第三步 综合
**综合**: 将HDL代码的描述 转换成 一种更接近电路的低层描述(即<font color=purple>网表</font>)  
**网表**: 描述了电路需要由`哪些标准单元` `如何连接`而成  

**综合的大致过程**:  
   1. *代码解析*: `根据语言规范`对HDL进行解析，并生成类似高级语言编译器的抽象语法树，包含了HDL代码中的<font color=blue>层次结构信息</font>  
   2. *多级综合*: 将解析到层次结构信息<font color=purple>转换为电路描述</font>  
   3. *工艺映射*: 将电路描述进一步转换为**<font color=purple>特定工艺</font>**的`标准单元`,输出网表  

### 第四步 物理设计
1. 布局: 确定每个标准单元在三维空间中的位置  
2. 布线: 根据网表描述的标准单元之间的连接关系，在三维空间中通过物理走线将相应的标准单元连接  
3. 静态时序分析: 延时最长的路径称为关键路径，可以根据关键路径的信息对电路设计进行迭代优化  
4. 电路和规则检查  
5. 生成物理设计结果  

### 第五步 投片生产或FPGA验证
**对于ASIC**: 将`版图文件`交付给晶元厂商后，厂商根据版图文件来生成相应的电路芯片  
**对于FPGA**: 将`比特流文件`下载到FPGA文件后，就可以将FPGA配置成目标电路的逻辑，可以在FPGA上开展系统级的验证工作  

# Verilog 语言简介
## 模块、端口和实例化
```Verilog
module 名称 (端口定义列表);
   内部信号定义
   语句功能描述
endmodule
```
一个Verilog源文件中可以有多个模块，且对排列顺序不做要求  
**模块的物理含义**: 可以表示一个存在物理边界的对象，如标准单元;或者特定功能逻辑部件  
**端口定义列表**: 
   - `input关键字`:定义模块的输入端口,用于连接输入模块内部的信号  
   - `output关键字`:定义模块的输出端口,用于连接输出到模块外部的信号  

**模块实例化**: 一个模块可以被实例化多次;
```verilog
组件或模块名称  实例标识符(端口关联列表);
```
一个模块内，`实例标识符`必须唯一  
**端口关联列表**形式:  
   - `按顺序关联`: 按照端口在基本组件或模块中定义的顺序进行关联。<font color=purple>适合端口数量较少</font>时  
   - `按名字关联`: 关联列表显式给出每个表达式所关联的端口名，不需要按顺序。<font color=purple>适合端口数量较多</font>时，可以提高可读性  

---
**模块的优点**: 可以通过端口隐藏内部的实现细节，这为数字电路设计提供了很大的灵活性  
**<font color=red>自顶向下的结构化建模方法</font>**: 借助抽象的思想，将复杂的数字系统`分解成若干模块`,并`通过模块和端口定义`将每个`模块的功能抽象`出来, 而不是立刻关注模块的内部实现.

---
**<font color=red>内置模块</font>**: Verilog有内置的基本门级元件26种，常用的有`非门(not)`,`与门(and)`,`与非门(nand)`,`或门(or)`,`或非门(nor)`,`异或门(xor)`,`等价门(也称同或门)(xnor)`,`缓冲门(buf)`  
```Verilog
module mux4_to_1 (
   input s0,s1,
   output y
);
   //内部网线声明
   wire s1_n,s0_n;
   //调用非门，生成s1_n,s0_n  
   not (s1_n,s1)
   not (s0_n,s0)
endmodule
```

## 标识符、常量和注释
### 标识符
**概念**: 任何用Verilog语言描述的"对象"都通过其名字来识别，这个名字被称为标识符,如`模块名`、`端口名`、`变量名`、`实例名`等，变<font color=purple>量名区分大小写</font>  
**关键字**: 用于`组织语言结构`或`定义门元件(原语)`,由小写字母组成  

**<font color=blue>标识符命名规则</font>**:  
   - 字符组成: 字母，数字，下划线和美元\$符号  
   - 通下划线加前缀/后缀表示特定意义:  
      - `Clk前缀`: 表示时钟信号  
      - `_n后缀`: 表示低电平有效信号  
   - 采用约定的统一所写，如全局复位信号都用`Rst`表示  

:bulb:<font color=purple>同一个信号</font>的命名在<font color=purple>不同层次要保持一致性</font>  
:bulb:<font color=red>各模块用大写表示参数</font>，如用SIZE表示长度参数  

### 常量
**整数常量的表示为**:  
```Verilog
<size>'<base><value>
```
- size: 常量的二进制位数，用十进制表示，<font color=purple>缺省为32</font>  
- base: 指定常数的基,可为二(b)、八(o)、十(d)、十六(h)进制,<font color=purple>缺省为十进制</font>  
- value: 指定进位制中任意有效数字，<font color=red>可以通过"_"来分割数字</font>   

> value的宽度大于位数时，截去高位  

> value中还可以包含x(非法值或不定态)和z(浮空值或高阻态);不同综合工具对x,z有不同的处理方式  

### 注释
单行注释: 以`//`开头  
多行注释: 以`/*`和`*/`界定  


## 数据类型
**网线类型(net)**: 用于表示元件或模块之间的<font color=purple>物理连接</font>,常用wire类型  
**寄存器类型(register)**: 表示抽象的存储元件，常用reg类型  
**参数类型(parameter)**: 给常量赋予有意义的标识符，提高可读性  

### wire类型
**意义**: 表示元件或模块之间的物理链接，对应物理电路中的连线,`传送信号`  
**使用须知**: <font color=red>需要被持续驱动</font>，`驱动源`可以是`门的输出`或`模块的输出端口`  
> `驱动信号`可以是wire,reg类型

**注意**: wire变量输入错误的变量名时，可能不会报错，而是将其按1位wire类型来处理  

### reg类型
**意义**: 用于表示存储元件,可使用reg类型变量描述触发器和锁存器.`存储值`  

### 向量和数组
**向量的定义**:  
```Verilog
wire[7:0] a; //一根位宽为8的连线
reg[31:0] rdata,wdata; //两个位宽为32的寄存器rdata和wdata
```
**向量的使用**:  
```Verilog
a[0] // 引用向量a的第0位  
a[3:0] //引用向量a的低4位
a  //整体引用
```
引用的部分下标范围称为`子界范围`  
子界范围<font color=red>通过常量给出</font>，其范围选取操作相当于一个信号分线器。Vivado综合时，会综合出位选择电路。若<font color=purple>不是常量</font>，则<font color=purple>可能无法进行综合</font>  

---
**数组的定义**: 有序界位于变量名之后,<font color=red>数组的长度不是$2^n$</font>  
```Verilog
wire b[2:0] // 表示数组b包含3跟位宽为1的连线
reg r[9:0] //表示数组r包含10个位宽为1的寄存器

```
**数组的使用**: `不能整体`进行操作，`不能引用其中的子界范围`。  
```Verilog
reg[MSB:LSB] <memory_name> [first_addr:last_addr] //描述一个存储器
```
> `[first_addr:last_addr]`定义存储器的地址范围，地址范围定义可以从高地址到低地址。也可以从低地址到高地址  

### parameter类型
**功能**: 用于表示有名字的常量  
**作用域**: 参数的定义是局部的，<font color=purple>作用域是当前模块</font>  

### <font color=red>模块端口类型</font> 
> 模块实例化建立了<font color=purple>父模块信号和子模块端口之间的关联</font>，这种关联在电路意义上可以被看作<font color=purple>物理连接</font>  

**子模块输入端口的关联**: 看作从父模块信号到子模块输入端口的物理链接，因此<font color=red>子模块输入端口只能定义为wire类型</font>.关联的父模块信号可为reg,wire  
**子模块输出端口的关联**: 看作从子模块输出端口到父模块信号的物理连接，因此`父模块信号只能为wire`<font color=purple>,子模块输出端口可为wire或者reg</font>  

#### 端口的定义和关联注意项
1. 模块端口可以定义为向量，但<font color=purple>不能定义为数组</font>  
2. 允许关联信号的位宽和端口位宽不同，但会给出警告  
3. 允许端口保持未关联状态，但会给出警告。缺省值为高阻态，综合时，会使用0作为缺省值，可能导致非预期结果，应避免使输入端口处于未关联状态  

## 运算符及其优先级
对于可综合电路来说,HDL中描述的任何含义和行为，都应由相应的电路结构来实现  
**<font color=purple>Verilog 中每一种运算符都有其对应的电路结构</font>**  
### 算术运算符
**种类**: "+","-","*","/","%"  

- **$+,-$运算符**:  
   - `运算结果位宽`: 两个操作数中位宽较长者再加1  
   - `综合`: 将综合出补码加减运算电路  
- **$*$运算符**:  
   - `运算结果位宽`: 两个操作数位宽之和  
   - `综合`: 阵列乘法器电路
- **$/,\%$运算符**:  
   - `运算结果位宽`: 与第一个操作数位宽相同  
   - `综合`: 有的生成阵列除法器电路，有的则会报错  

:bulb:阵列乘法器和真累触发器的电路延迟比较大，不利于频率的提升。在面向高性能的处理器设计中，一般会编写其他类型的乘法器和触发器来提升电路的性能，而不直接使用"*","/","%"这些运算符  


### 位运算符
**单目运算符**: "~"  
**双目运算符**: "&","|","^","~^"  

**运算结果**: 位宽与操作数的位宽相同，若两个位宽不同的操作数进行位运算，<font color=purple>位宽较短的操作数</font>将<font color=purple>先进行零扩展</font>  
**综合**: 综合出数量与位宽相同的一个或多个非门，与门，或门，...  

### 归约运算符
**种类**: "&","~&","|","～|","^","~^"或"^~"  
**特性**: 均为单目运算符;归约运算结果位宽均为1  
**运算过程**: 先将操作数的最低位与次低位进行与,或,异或运算。再将运算结果与上一个次低位进行相同的运算，依次类推，直至最高位。  
**综合**: 若信号a位宽为4,则$&a$则会综合出一个四输入与门。其他类似  

### 逻辑运算符
**单目运算符**: "!"逻辑非  
**双目运算符**: "&&","||"  
**规则**: 将操作数当作布尔值; 运算结果的位宽均为1  
**操作数到布尔值的转换**: 对操作数进行`归约或运算`  
```Verilog
a && b = (|a) & (|b)   // 可以的出综合的电路
```
### 等式运算符
**双目运算符**: "!=","=="  
**运算流程**: 将两个操作数的每一位分别进行比较  
**运算规则**: 若操作数位宽不一致，则对位宽短的先进行`零扩展`  
**综合**: 将等式转换为用归约运算符和位运算符的表达，即可得到其综合出的电路  
```Verilog
(a == b) = ~(|(a^b))
(a != b) = |(a^b)
```

### 关系运算符
**双目运算符**: "<","<=",">",">="  
**运算结果**: 运算结果的位宽均为1  
**综合**: 带标志位的补码加减运算电路,电路做减法运算，最后输出标志位来判断关系的真假  


### 位拼接运算符
**运算符**:`{}`  
**功能**: 将两个或多个信号`按顺序拼接`起来，<font color=blue>操作数之间用","分开</font>.唯一一个操作数数量可变的运算符  
**综合**: 该运算符行为相当于一个信号集线器，可将多个信号按顺序排列，以组成一个新的向量信号，因此并<font color=purple>不综合出额外的逻辑门器件</font>  
```Verilog
{n{m}} //将操作数m重复拼接n次
a = 2'b11
b = 4'b1101 
{a,b[1:0],3'b0} = 7'b1101000
{a,{2{c,b}}} = {a,c,b,c,b}
```

### 移位运算符
**双目运算符**: `<<`,`>>`  
**运算规则**: 用相应移动位数的数量的0来填补移出的空位  
```Verilog
4'b1001>>3 = 4'b0001
4'b1001 << 2 = 6'b100100
```
**综合**:
```Verilog
(a >> b) = {{b{1'b0}}, a[wa-1:b]} // wa分别为a的位宽
(a << b) = {a,{b{1'b0}}}
```

### 条件运算符
**三目运算符**: `?:`  
**用法**: `条件?表达式1:表达式2`  
**运算结果**: 结果的位宽与表达式的位宽相同，若两个表达式位宽不同，则较短的表达式将进行零扩展  
**综合**: `综合出二路选择器`,输入和输出的位宽和表达式的位宽相同，条件对应的电路输出将作为二路选择器的控制信号  

### 运算优先级
![img](img/运算符的优先级.png '图11 运算符的优先级 :size=50%')  
编写表达式尽量用括号显示地表示预期的行为，提高程序的可读性  

# Verilog 建模方式
## 三种建模方式
### 结构化建模方式
**简介**: 将电路描述成一个分级的子模块系统，并通过逐层调用子模块来构成功能复杂的数字系统  

**分类**:   
   1. `模块级结构化建模`: 通过调用由`用户设计的子模块`对电路进行建模  
   2. `门级结构化建模`: 调用`Verilog内建的基本门级元件`来对电路进行建模.相当于电路的门级结构图的直接翻译    
      - 优点: 可以对电路的结构进行精确的控制，在关键路径优化上可以起到明显的效果  
      - 缺点: 电路规模大时，门级结构化建模会非常繁琐，容易出错，代码维护困难.<font color=purple>大部分项目不从门级角度进行设计</font>  
   3. `开关级结构化建模`: 通过调用Verilog内建的基本开关元件(如晶体管等)来对电路进行建模  

### 数据流建模方式
**简介**: 从数据的视角出发，通过描述数据在电路中的流动方向来描述电路的功能.<font color=purple>可用于对组合逻辑电路进行描述;时序逻辑电路涉及数据的存储和更新，因此不适合</font>  

**用法**: 通过`连续赋值语句`进行建模  
```Verilog
assign 网线 = 表达式; //用表达式描述的电路的输出驱动赋值号左边的网线
```
> `网线数据类型`: 只能是wire类型变量(可以是标量，向量，多个wire拼接)  
> `表达式类型`: 可以是wire,reg  

**注意事项**:  
1. 多个连续赋值语句之间是`并行关系`  
2. 连续赋值语句对一个未定义的变量进行赋值时，相当于对一个位宽1的wire类型变量进行驱动  
3. 不能对相同的网线进行重复驱动  
4. 所描述的电路不能出现组合逻辑回路  
5. 可以在定义wire变量的同时给出驱动他的表达式，<font color=purple>效果等同于先定义再用连续赋值语句</font>  
6. 对模块实例的输入端口进行关联，本质上也是一种连续赋值语句  

**用途**: 大部分组合逻辑电路都是采用数据流建模方式来描述的  

### 行为建模方式
**简介**: 从整个系统的功能方面考虑，编码时无需关注电路的具体结构，而由综合器根据过程块所描述的行为综合出实现该行为的电路结构  
**注意**: 需要充分理解高级语言特性和可综合电路之间的关系，才能写出可读性好的行为建模代码  
**关键要素always语句**:  
```Verilog
always @ (事件信号列表) 过程语句
```
- **含义**: 当事件信号列表中任何一个信号发生变化时，过程语句中的信号将按照所描述的行为进行更新  
- **注意**:<font color=>被赋值的只能是reg类型变量</font>  
- **事件信号列表**: 
   - 可以有单个或多个信号.有多个信号时,信号之间用`关键字or`或`逗号`来连接  
   - 事件信号可以添加关键字`posedge`或`negedge`修饰，分别表示之检测上升沿和只检测下降沿  
   - `*`:表示隐式事件信号列表，是<font color=purple>过程语句中赋值号右侧</font>`所有信号的集合`的一种简写方式  
- 可以有多个always语句，他们之间是<font color=purple>并行关系</font>，所描述的电路与这些语句之间的<font color=purple>位置顺序无关</font>  

## 行为建模中的过程语句
**要求**: 知道各种语句综合时生成的电路  
### begin-end复合语句
**功能**: 在语法上，<font color=purple>将多条语句看成一条语句</font>。相当于c的大括号`{}`  

### 两种过程赋值语句
**阻塞赋值语句语法**:  
```Verilog
寄存器 = 表达式 
```
**非阻塞赋值语句语法**:  
```Verilog
寄存器 <= 表达式 
```
**注意**: 允许在`一个always语句中`对`同一个reg类型变量`进行`多次赋值`,以最后一次赋值为准。但不允许在`多个always语句`中对`同一个reg类型变量`进行赋值,因为这相当于多个电路逻辑同时驱动同一个组合信号或更新同一个触发器  

**阻塞赋值更新时机**: `立即更新`  
**非阻塞赋值更新时机**: `滞后更新`，执行完在所有语句后，才会更新寄存器的新值,在此之前表达式中所用变量的值都是旧值.即<font color=purple>一组非阻塞语句是并行计算的</font>，因为其表达式中同一变量的值是相同的  

**阻塞逻辑电路用途**: 结合`隐式时间列表*`的always语句，可以用于描述组合逻辑电路  
**非阻塞逻辑电路用途**: 在以边沿事件时间变量作为事件信号列表的always语句中，可以用来描述时序逻辑电路  

**注意**: 允许两种赋值方式混合使用，但其电路行为是难以理解的，可能无法综合出预期的电路，不推荐如此做  

### if-else 语句
> :bulb:  使用时一定要覆盖所有条件,或者在if后面用else结尾(也等价于覆盖所有条件)  

**综合**: `多路选择器`  
**规则1**: 只更新单个寄存器变量的嵌套if-else语句.功能<font color=purple>等价于嵌套的条件运算符</font>,即综合电路也一样  
```Verilog
always @ (posedge clk)
   if (cond1) val <= expr1;
   else if (cond2) val <= expr2;
      .....
   else if (condn) val <= exprn;
   else val <= expr_last;
//等价于
always @ (posedge clk)
   val <= (cond1 ? expr1: (cond2 ? expr2 : .... (condn ? exprn : expr_last)));
```

**规则2**: 只更新单个寄存器变量的多个并列if语句，其可以用嵌套的if-else语句来表示。但一定要保证多个并列的i分语句描述的条件覆盖了所有情况  
```Verilog
always @ (posedge clk)
   begin
   if (cond1) val <= expr1;
   if (cond2) val <= expr2;
      .....
   if (condn) val <= exprn;
   end
//等价于
always @ (posedge clk)
   if (cond1) val <= expr1;
   else if (cond2) val <= expr2;
      .....
   else if (condn) val <= exprn;
   else val <= val;
end
```
**规则3**: 更新多个寄存器变量的if-else语句，功能等价于`按照变量`将always语句`分开编写`  
```Verilog
always @ (posedge clk)
   if (cond1) begin
      val1 <= expr1;
      val2 <= expr2;
   end
   else val1 <= expr3;
end
//等价于
always @ (posedge clk)
   if (cond1) val1 <= expr1;
   else val1 <= expr3;
always @ (posedge clk)
   if (cond1) val2 <= expr2;
```

**注意**: 若代码中条件分支`没有覆盖所有情况`，则<font color=red>会生成一个锁存器</font>来`实现存储数据的功能`。所以无法通过组合逻辑电路来描述.同时时序逻辑电路，也不希望使用锁存器，锁存器数据更新通过电平触发，实际电路中，难以预测，会给时序分析带来困难  


### case语句 
**用途**: 一般用于译码器、多路选择器、状态机等电路中  
**使用注意事项**: 在描述组合逻辑电路且case语句的分支没有覆盖所有情况时，一定要给出default分支并对相应变量进行赋值，否则会生成锁存器  
**语法**:
```Verilog
case (expr0)
   expr1: statement1
   expr2: statement2
   ......
   exprn: statementn
   [default: statement_default]
endcase
```
**综合**: 可以等价成if-else的综合电路  
```Verilog
if (expr0 == expr1) statement1
else if (expr0 == expr2) statement2 
...
else if (expr0 == exprn) statementn 
[else statement_default]
```

### 循环语句
**语义**: 从空间上重复描述相似的电路。可以用if语句对for循环进行展开来帮助理解,但不仅仅只有这一种展开方式  
**语法**:  
```Verilog
for(expr1; expr2; expr3) statement
```
```Verilog
//将for循环用if语句表示
expr1;
if (expr2) begin
   statement
   expr3;
end
if (expr2) begin
   statement
   expr3;
end
if (expr2) begin
   statement
   expr3;
end
..... //重复若干次，知道expr2条件不满足为止
```

循环条件expr2除了循环变量之外还含有其他变量时，电路将变得很复杂  
```Verilog
for (i=0; i<threshold;i=i+1) //threshold是位宽为3的变量
   hit_vector[i] = (array[i] == num);
//展开并简化后
if （0 < threshold) hit_vector[0] = (array[0] == num);
if （1 < threshold) hit_vector[1] = (array[1] == num);
if （2 < threshold) hit_vector[2] = (array[2] == num);
if （3 < threshold) hit_vector[3] = (array[3] == num);
if （4 < threshold) hit_vector[4] = (array[4] == num);
if （5 < threshold) hit_vector[5] = (array[5] == num);
if （6 < threshold) hit_vector[6] = (array[6] == num);
if （7 < threshold) hit_vector[7] = (array[7] == num);
```
> 没有else分支，明显可知条件覆盖不全，因此综合器还会为`hit_vector`生成相应的锁存器，违背了设计者的初衷  

**实际意义**:对可综合电路来说，for循环只是重复代码的一种简写方式，可按照在空间上展开的结果来综合出相应的电路.  
**使用须知**: 要先明确电路的功能需求，然后思考for循环展开后描述的电路是否符合预期  


