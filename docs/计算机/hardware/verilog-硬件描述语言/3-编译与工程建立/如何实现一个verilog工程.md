# 需要的文件
.v,.cpp,Makefile

## 含多个.v文件的工程
可以通过-I参数来指定.v文件的搜索目录  
<font color=red>(必要的)</font>通过--top-module <modulename> 指定顶层模块的名字  

## 如何写一个用于仿真的cpp文件

### 类介绍

#### VerilatedContext
包含了仿真时间  
定义: `VerilatedContext* context = NUll;`

#### VerilatedVcdC
要导出vcd时需要使用，包含在“verilated_vcd_c.h”头文件中  
定义: `VerilatedVcdC* tfp = NUll;`  

### 函数介绍
```cpp
VerilatedContext* contextp = new VerilatedContext;
VerilatedVcdC* tfp = new VerilatedVcdC;
Vtop* top = new Vtop;
```
#### eval()
当input变量发生改变时，必须使用eval()  
```cpp
top -> eval();
```

#### timeInc()
推进仿真时间  
```cpp
contextp->timeInc(1);
```

#### dump()
在eval()之后使用  
```cpp
tfp->dump(contextp->time());
```

#### traceEverOn()
启用跟踪  
```cpp
contextp->traceEverOn(true);
```

#### trace()
跟踪模块中的信号  
```cpp
top->trace(tfp,0);
```

####  open()
打开新的vcd文件，里面存储了每次调用时的完整转储数据  
```cpp
tfp->open("wave.vcd");
```

#### close()
停止转储  
```cpp
tfp->close();
```

