# 用RTL实现最简单的处理器
我们设计的处理器**统称为<font color=blue>NPC(New Processor Core)</font>**  

**要实现的部件**: `PC`,`寄存器`,`加法器`,`存储器`  

**按照处理器工作的流程给`RTL项目`划分模块**:  
- `IFU(Instruction Fetch Unit)`: 负责根据当前PC从存储器取出指令  
- `IDU(Instruction Decode Unit)`: 负责对当前指令译码。并准备执行阶段需要使用的`数据`和`控制信号`  
- `EXU(Exectuion Unit)`: 根据`控制信号`对数据进行执行操作，并将执行结果写回寄存器或存储器  
- `更新PC`: 通过RTL实现时，一般与PC寄存器一同实现，因而`无需为此划分一个独立的模块`  

独立决定，将功能部件的放置在哪个模块中  

**存储器的实现**: 通过C++代码实现。因此需要<font color=red>将存储器访问接口的信号拉到顶层</font>，通过C++访问存储器  
```Cpp
while (???) {
  ...
  top->inst = pmem_read(top->pc);
  top->eval();
  ...
}
```

## 若干代码风格和规范
1. 使用verilog时: 在模块名前添加学号前缀  
   - 如`module IFU`定义为 `moduole ysyx_22050499_IFU`  
2. 使用verilog时: 在宏定义的标识符前添加学号前缀  
   - 如`define ysyx_22050499_SIZE 5`  



