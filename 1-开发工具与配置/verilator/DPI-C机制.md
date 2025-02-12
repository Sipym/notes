# DPI-C (Derect Programming Interface)
**简介**: 可以在verilog代码中调用`C/C++`定义的C函数  

## 使用方法
1. Verilog中，使用如下，**来声明一个C函数**.可以在`.v`文件的开头或模块内  
```verilog
import "DPI-C" function <return_type> <function_name>(<argument_list>);
```
2. verilog,使用如下方式，**调用函数**  
```verilog
<function_name>(<argument_list>);
```

3. 在c中定义这个函数;  
4. 在c中添加头文件  
```c
#include "svdpi.h"
#include "V<top_module>__Dpi.h"
```
