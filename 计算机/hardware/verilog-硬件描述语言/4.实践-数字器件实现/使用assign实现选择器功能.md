# 在四个输入总线之一之间进行选择，并将所选总线连接到输出总线 
```verilog
module select_bus(busout, bus0, bus1, bus2, bus3, enable, s);
    parameter n = 16;
    parameter Zee = 16'bz;
    output [1:n] busout;
    input [1:n] bus0, bus1, bus2, bus3;
    input enable;
    input [1:2] s;
    tri [1:n] data;         //net声明

    //net declaration  with continous assignment
    tri [1:n] busout = enable ? data : Zee;

    // 四个连续赋值语句，实现了一个选择功能  
    assign
        data = (s == 0) ? bus0 : Zee,
        data = (s == 1) ? bus1 : Zee,
        data = (s == 2) ? bus2 : Zee,
        data = (s == 3) ? bus3 : Zee;

endmodule 
```
