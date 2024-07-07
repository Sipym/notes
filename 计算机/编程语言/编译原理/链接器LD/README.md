# LD概述
ld 组合了许多"object"和"archive"文件，<font color=purple>重定位</font>它们的数据并<font color=purple>绑定符号引用</font>。通常编译程序的最后一步是运行 ld  

**特性**:  
- > 允许`ld` `读取`，`组合`和`写入`多种不同格式的<font color=green>目标文件</font>,详细可以参考[BFD](https://sourceware.org/binutils/docs/ld/BFD.html)  
