# SoC

## 链接脚本的编写
**<font color=red>遇到的难点(已解决)</font>**: .data节的长度为0  
- >`解决方法`: 通过`--print-map`参数，得知<font color=green>全局变量的数据名为$ .data.a$,$ .sdata.*$,因此在`.data`节中添加了这些进去</font>，从而就实现了  


