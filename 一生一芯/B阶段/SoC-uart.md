## uart_regs.v阅读心得
`dlab`: 写DV寄存器的使能信号
`start_dlc`: 只有在wb_we_i=1,wb_addr为tx,dlab=1时，才能为1
`enable`信号: 当dlc从dl减为0时， enable = 1;
`thre_set_en`: 当fifo为空，开始写入一个字符时，一个字符周期(见always @(lcr)部分)后，thre_set_en会置1

## uart_transmiter.v阅读心得
`tstate`: 整个状态机的变化过程，需要保证enable = 1

`stx_pad_o`: output端，用于输出串行数据,即uart_tx
   - > 值由`stx_o_tmp`决定，下面对其进行介绍

`stx_o_tmp`:
   1. <font color = red>复位时默认为1</font>,tstate处于idle状态时为1
   2. 当状态tstate从`idle`->`s_pop_byte`->`s_send_start`时: <font color = red>stx_o_tmp被置0</font>, 用于告诉通信设备，我要准备发送数据了
      - > 持续时间: 为`5'b01111`个时间周期
   3. 计数counter个周期后,状态tstate从`s_send_start`->`s_send_byte`: 此时有多少个`bit_counter`，则会重复多少个`counter`周期(一个`counter`周期发送`1bit数据`)
      - <font color = red>stx_o_tmp = bit_out</font>   
         - > 持续时间: `counter = 5'b01111`个时间周期  
   4. 如果没有校验位,则tstate从`s_send_byte`->`s_send_stop`: <font color = red>stx_o_tmp置1</font>
      - > 持续时间: 持续counter个周期,counter大小根据停止位大小的不同而不同  


### NPC如何实现接受rx的数据
实现: ioe_read(uart_rx);
```c
   if (lsr0 == 1) { //当lsr0 = 1时，表示有数据,则读数据
      /*是否判断uart溢出的情况*/
      uart_read;
   } else {
      return 0xFF;
   }
```

