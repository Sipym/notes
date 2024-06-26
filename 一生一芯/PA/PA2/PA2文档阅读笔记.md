# PA2
## CPU是如何执行一条指令的
> 大部分指令都可以抽象成:`取指-译码-执行`的指令周期

### 取指: 本质上就是一次内存的访问  
**原理**: 将pc(地址)指向的指令从内存中读入到CPU中  
**实现**: 使用函数`inst_fetch()`实现  

---

### 译码: 从指令中解读出`操作码`和`操作数`
**实现原理**: 通过查看指令的`opcode`  

**实现函数**: `decode_exec()`  

**译码方式**: 模式匹配  
> `概念`:通过一个模式字符串来指定指令中`opcode`  

> <font color=purple>模式匹配具体模式</font>:
>>1 `INSTPAT_START();`  
>>2 `INSTPAT("??????? ????? ????? ??? ????? 01101 11", lui, U, R(dest) = imm);`  
>>3  ...  
>>4 `INSTPAT_END();`  

> `模式匹配规则格式`: `INSTPAT(模式字符串, 指令名称, 指令类型, 指令执行操作);`  
>> 如指令lui的模式匹配规则如下: `INSTPAT("??????? ????? ????? ??? ????? 01101 11", lui, U, R(dest) = imm);`  

> 模式匹配规则`inv`: <font color=red>若前面所有的模式匹配规则都无法成功匹配，则该指令视为非法指令</font>  

---

### 执行
执行模式匹配规则中指定的`指令执行操作`  

---

### 更新pc: 指向下一条指令的位置
**实现**:将`s->dnpc`赋值给`cpu.pc`  

---


### 运行第一个c程序
第一个简单的c程序: `am-kernels/tests/cpu-tests/tests/dummy.c`  


# 散乱知识
### 静态指令和动态指令
静态指令snpc: 程序代码中的指令  
动态指令dnpc: 程序<font color=purple>运行过程中</font>的指令  
```
100: jmp 102
101: add
102: xor
```
> 分析: `jmp`指令的下一条静态指令是`add`指令, 而下一条动态指令则是`xor`指令.

---
### 符号扩展
符号扩展: 是计算机算术中，在保留数字的符号及数值的情况下，增加二进制数字位数的操作  





