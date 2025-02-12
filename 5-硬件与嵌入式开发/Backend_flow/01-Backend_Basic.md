# 后端基础知识

## ASIC(专用集成电路) 介绍
ASIC类芯片: 为<font color = red>特殊用途</font>而定制设计的芯片。如智能手机处理器。

ASIC设计流程对于确保ASIC设计成功至关重要，基于对ASIC规范、要求、低功耗设计和性能的全面了解。  

**实现ASIC所需的主要步骤**:  
- `设计输入RTL`: 使用硬件描述语言(HDL)来描述逻辑设计，通常在<font color = purple>数据流(寄存器传输RTL)</font>或<font color = purple>行为</font>级别完成的   

- `功能验证verilator`: 必须<font color = blue>根据要求检查上述的RTL描述</font>，可以通过模拟(仿真)或形式化方法来验证。对<u><font color = purple>RTL描述</font></u>以及通过以下步骤生成的<u><font color = purple>网表</font></u>进行**功能验证**。

- `综合yosys`: <font color = blue>将HDL描述转换成网表</font>的逻辑单元电路。  

- `布局/物理综合`:也称物理实现,将<font color = blue>逻辑电路转换为用于制造的光刻掩膜的布局</font>。这一复杂的步骤涉及多个子步骤，通常通过自动化流程完成。其中“单元布局”和“布线”最为耗时，<font color = red>该步骤也称为“布局与布线PnR"</font>
   - 芯片平面设计: 确定各个功能模块的宏观布局
   - 单元布局
   - 时钟树综合  
   - 布线

- `Signoff(签署)`: ASIC设计的最后阶段，确保你的创作完美运行、高效运行、并最终兑现其承偌，将您的芯片蓝图发送到硅片刻蚀制造  

![img](img/ASIC_Flow.png '图1 ASIC Flow  :size=60%')


## :star:芯片物理构成
![img](img/芯片剖面图.png '图1 芯片剖面图  :size=60%')  

> :star: <font color = red>我对芯片的理解： 通过不同层的不同性质，在不同的层间组合之间实现各种器件(`器件全在最底层,金属层全是布线`)，并通过金属层连接起来。</font>  

### 芯片剖面图详细解析

#### 材料与工艺层
- **TOPNIT**: 氮化物材料，用作保护层。<font color = darkred>用于避免金属层受外界影响</font>，如湿气或其他污染  

- **NILD**: 氮化物层间介质层，分为多个层次(NILD2,NILD3,...). <font color = darkred>隔离金属层并提供电气绝缘</font>。  

- **LINT**: 较低介电常数的氮化物材料。<font color = darkred>主要用于层间绝缘</font>。  

- **PSG**: 磷硅玻璃，用于表面钝化层或层间介电层  

- **FOX**: 场氧化层。<font color = darkred>用于隔离不同的器件区域，防止寄生效应(<u>如寄生电容，电阻等)</u></font>。  

- **TOPOX**: 最顶部的氧化物层。<font color = darkred>起到绝缘和保护作用</font>。  

#### 结构和器件
- **field poly**: 场多晶硅。<font color = darkred>用于形成晶体管的<u>栅极结构</u>，作为导电材料</font>。  

- **licon**: 金属层与下层半导体(如扩散区)之间的接触  

- **Mcon**: 金属接触层，连接金属层与底层接触点(如Licon)  

- **Metal**: 金属布线层，<font color = red>用于在芯片内形成电路链接</font>。  

- **glass cut**: 玻璃切割，<font color = darkred>指芯片顶部用于保护的玻璃材料的划分区域</font>。  


#### 电容与区域
- **p-substrate(P型衬底)**: 整个芯片的基础材料，位于芯片的最下面。

- **n well(N型阱)**: 在`p-substrate`上<font color = darkred>掺入N型杂质</font>形成的区域，用于实现某些类型的器件，如PMOS晶体管。

- **diffusion(扩散区)**: 通过掺杂工艺形成的区域，用于<font color = darkred>形成晶体管的源极和漏极</font>。  

- **cap2m**:？？？


#### 其他

- **Via(通讯,过孔)**: 用于<font color = darkred>连接<u>相邻金属层</u>的垂直通路</font>。  

- **polysilicon gate**: 多晶硅栅极,<font color = darkred>晶体管的栅极</font>。  

### 芯片各个层
**基础层**(`p-substrate`,`N-well`): 
   - > 提供芯片的物理支持，并决定基体的导电特性  
   - > 通过`diffusion`，<font color = darkred>形成晶体管的源极、漏极等基础器件</font>。  

**介电层**(`FOX`、`PSG`、`NLID`等):  
   - > 具有高电阻率，<font color = darkred>起到电气绝缘的作用，避免信号在非目标区域泄露</font>  
   - > 某些介电材料，还具<font color = darkred>有良好的钝化作用，保护芯片 免受污染</font>。  

**多晶硅层**(`field poly`):  
   - > 主要是用于<font color = darkred>形成晶体管的栅极</font>，通过控制栅极电压调节器件的开关状态  

**金属层**:  
   - > 用于在芯片内建立电器链接，将各个晶体管和其他元件组成完整的电路  
   - > 金属层之间通过通孔(via)互联，实现三维电路布局。  


### 器件实现
通过组合这些层，可以构建各种功能的器件，例如：  

- **CMOS晶体管**
   - > 由 N-well、P-substrate、扩散区、多晶硅（栅极）及金属层等组成。
- **电容器**
   - > 利用金属层和介电层的组合（如Cap2m），实现电荷存储。
- **互连电路**
   - > 通过金属层将这些基础器件组合成功能复杂的电路（如逻辑单元、存储单元等）。


