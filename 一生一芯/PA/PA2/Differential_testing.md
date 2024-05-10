# DiffTest
**使用**: 提供一个和DUT(Design Under Test)测试对象)功能相同但实现方式不同的REF(Reference,参考实现),然后让它们接受`相同`的有定义的`输入`，观测它们的`行为是否相同`  

**nemu中使用**: 让在NEMU中执行的每条指令在真机中执行一次，然后比较NEMU和另一模拟器的状态(<font color=red>检查各自寄存器和内存的状态</font>),如果不一致，马上报告错误，停止客户程序的执行  
   - <font color=green>状态</font>: 表示成`S = <R,M`,其中`R`是寄存器的值，`M`是内存的值  

**DUT,REF之间相关API**:  
```c
// 在DUT host memory的`buf`和REF guest memory的`addr`之间拷贝`n`字节,
// `direction`指定拷贝的方向, `DIFFTEST_TO_DUT`表示往DUT拷贝, `DIFFTEST_TO_REF`表示往REF拷贝
void difftest_memcpy(paddr_t addr, void *buf, size_t n, bool direction);
// `direction`为`DIFFTEST_TO_DUT`时, 获取REF的寄存器状态到`dut`;
// `direction`为`DIFFTEST_TO_REF`时, 设置REF的寄存器状态为`dut`;
void difftest_regcpy(void *dut, bool direction);
// 让REF执行`n`条指令
void difftest_exec(uint64_t n);
// 初始化REF的DiffTest功能
void difftest_init();
```
> <font color=skyblue>寄存器状态dut</font>: <font color=red>要求寄存器的成员按照某种顺序排列</font>  

## 实现
-  **第一步**:调用`nemu/src/cpu/difftest/dut.c`和`init_difftest()`  
   - 进行相关初始化工作,使`DUT`,`REF`处于相同状态  
- **第二步**: `difftest_step(当前指令pc值,下一条要执行指令的pc值即dnpc)`  
   - 比较逐条指令执行后的状态  


## 我的实现
1. 实现了`isa_difftest_checkregs()`: 把通用寄存器和PC与从DUT中读出的寄存器的值进行比较. 若对比结果一致, 函数返回true; 如果发现值不一样, 函数返回false  

## 注意
- Spike不支持不对齐的访存(<font color=red>还不理解</font>)  
   - RISC-V作为一个RISC架构, 通常是不支持不对齐访存的, 在Spike中执行一条地址不对齐的访存指令将会抛出异常, 让PC跳转到0. 但NEMU为了简化, 没有实现这样的功能, 因此如果让NEMU和Spike同时执行这样的指令, DiffTest将会报错. 不过这很可能是你的软件实现(例如klib)有问题, 请检查并修改相关代码
