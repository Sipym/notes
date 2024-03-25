# linux stm32开发全过程
1. 借助`CubeMx`<font color=purple>生成对应芯片的`flash`和`.s`文件</font>  

2. 使用已经写好了的Makefile来生成hex文件  
   - 在makefile中<font color=brown>根据使用的下载器类型</font>更改相应选项  

3. 使用`bear -- make`可以生成各个文件之间的关系，方便clangd进行函数变量等的跳转  

4. 使用`make download`将程序下载进芯片   

## 面临的问题
1. 不能使用标准库函数(如`printf()`函数)，暂未解决  

