# 端口定义
```verilog
//input_declaration
input [net_type] [signed] [range] list_of_port_identifiers;

//output声明
output [net_type] [signed] [range] list_of_port_identifiers;
output reg [signed] [range] lis_of_variable_port_identifiers;
output ouput_variable_type lis_of_variable_port_identifiers;

//inout 声明
inout [net_type] [signed] [range] list_of_port_identifiers;
```
由上可知，input,inout只能是net型数据;
ouput可以是varialbe，net型。  


