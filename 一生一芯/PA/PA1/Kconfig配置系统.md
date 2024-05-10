# nemu 配置系统和项目构建
[参考链接](https://ysyx.oscc.cc/docs/ics-pa/1.3.html#%E9%85%8D%E7%BD%AE%E7%B3%BB%E7%BB%9F%E5%92%8C%E9%A1%B9%E7%9B%AE%E6%9E%84%E5%BB%BA)
# 配置系统kconfig - 管理形如`CONFIG_xxx`的宏定义
<font color=blue>源文件</font>:`nemu/tools/kconfig`  
<font color=blue>编写</font>: 使用如下语言来编写"配置描述文件"  
   - 配置选项的属性, 包括类型, 默认值等  
   - 不同配置选项之间的关系  
   - 配置选项的层次关系  

<font color=blue>运行</font>:`make menuconfig`  

<font color=blue>当前配置系统的配置</font>:  
   - `nemu/include/generated/autoconf.h`, 定义一些形如`CONFIG_xxx`的宏，可以**在c代码中通过条件编译的功能对这些宏进行测试，来判断是否编译某些代码**。  
   - `nemu/include/config/auto.conf`, 阅读Makefile时使用  

**编写`nemu/Kconfig`文件来添加想要的宏定义**  

## 文件列表: 决定最终参与编译的源文件
根据`menuconfig`的配置对`nemu/src/filelist.mk`中的变量进行维护  
   - `SRCS-y` - 参与编译的源文件的候选集合
   - `SRCS-BLACKLIST-y` - 不参与编译的源文件的黑名单集合
   - `DIRS-y` - 参与编译的目录集合, 该目录下的所有文件都会被加入到SRCS-y中
   - `DIRS-BLACKLIST-y` - 不参与编译的目录集合, 该目录下的所有文件都会被加入到SRCS-BLACKLIST-y中

