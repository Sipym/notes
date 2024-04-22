# itrace - 指令执行的踪迹
**实现**: `nemu/src/cpu/cpu-exec.c`  
**原理**: 通过`snprintf`函数将`指令`，`当前pc`写入`Decode结构体`中的`字符数组log_buf`中。并通过函数`disassemble()`<font color=sky_blue>实现反汇编</font>(根据指令对应的机器码翻译出指令，如0000系列数字翻译成 add rd,rs1).最后通过`trace_and_difftest()`函数<font color=sky_blue>将`log_buf[]`写入log文件</font>      

# iringbuf - 指令环形缓冲区
