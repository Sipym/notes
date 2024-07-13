# ysyxsoc源码阅读

## APBFanout apbxbar
**功能**: 根据地址解码，将`信号`路由到<font color=purple>相应的APB外设</font>  

**具体实现**: 通过`sel_num`信号  

<font color=darkgreen>以sel_0实现为例</font>:  
```verilog
  wire        sel_0 =
    {auto_in_paddr[31], auto_in_paddr[29], _GEN[16], auto_in_paddr[16], _GEN[1:0]} == 6'h0
    | {auto_in_paddr[31], ~(auto_in_paddr[30:28])} == 3'h0;	
```
- 其代表了两段地址:0x10001000和0x30000000.即<font color=red>选择了flash和spi两个外设</font>  

## apb_delayer apbdelay_delayer
**功能**:  是一个 APB 协议转换器，它的主要功能是引入延迟，以确保 APB 总线上的事务按照正确的时序进行。这对于某些需要精确控制时序的应用场景非常重要。

**对SPI,flash的影响**: 还没看源码，<font color=purple>目前没发现有影响</font>  


##  AXI4ToAPB
**功能**: 它的主要功能是将 AXI4 事务转换为 APB 事务，以便在 APB 总线上进行传输。这是通过将 AXI4 协议的各个信号（如地址、数据、控制信号等）转换为相应的 APB 协议信号来实现的。转换过程中，它还需要处理 AXI4 和 APB 协议之间的时序差异。


## AXI4xbar_1
**功能**: cpu事务可以通过xbar路由到xbar_1

requestARIO_0_0: 选择的是SPI和flash  



## <font color=red>复位</font>  
> :bulb: <font color=green>有时候无法正确通信，是复位的问题</font>  

soc中复位时间较长(且复位成功后会自动置一)，故需要延长复位时间，避免出错。  

