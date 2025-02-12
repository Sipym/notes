# 关于编译
`make`程序默认使用单线程来顺序的编译所有文件。  
## 采用多线程编译并行编译文件
在make后加上参数`-j?`,？为任意数字，最大为cpu数量  
使用`lscpu`来查询系统中有多少个CPU  
在make前<font color=purple>加上一个time，time会对紧跟在其后的命令的执行时间进行统计</font>  

