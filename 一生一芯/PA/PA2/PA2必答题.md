# PA2
## RTFM
**题目**:  整理一条指令在NEMU中的执行过程  

**解答**: auipc指令的执行过程  
> 1. 进入sdb_mainloop()函数后，等待用户的指令 
> 2. 输入si 1,将执行客户用户程序的第一条指令`auipc to,0`  
> 3. 一系列步骤后，将执行`isa_exec_once()`函数，用于取指，译码并执行   
> 4. 取指: 使用`inst_fetch()`函数获取指令  
> 5. 进入译码函数`decode_exec()`  
> 6. 模式匹配，根据指令特定的opcode找到该指令的模式匹配规则  
> 7. 执行函数`decode_operand()`,获取rd的值  
> 8. 因为类型为`TYPE_U`,执行`immU()`获取立即数  
> 9. 执行命令:`R(dest) = s->pc + imm;`  

---


