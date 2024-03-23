# readline 介绍
`char * readline (const char *prompt);`  
readline从终端获取一行字符串并返回它。  
返回的那一行由`malloc`分配,调用方在<font color=purple>使用完</font>后<font size=5>必须释放</font>它。  
返回的那一行的<font size=5>最后的换行符被删除</font>了，即只保留了该行的文本。  

## prompt参数
使用`prompt`作为一个提示，如果`prompt!=NULL`，则每次返回时都会返回一个提示  

### 例子
`readline("(nemu) ");`  
realine每次从终端获取一行字符串时，都会显示一个`(nemu) `  


## readline与gets的区别

readline提供了<font color=purple>行编辑功能</font>  
Readline在用户输入行时提供编辑功能。默认情况下，行编辑命令与emacs中的命令类似。vi风格的行编辑界面也是可用的  

## 使用时要包含的头文件  
```cpp
#include <stdio.h>
#include <readline/readline.h>
#include <readline/history.h>
```

# 返回值
Readline返回`所读行的文本`,空行返回`空字符串`。  
如果在读取一行时遇到EOF，并且该行为空，则返回NULL。  
如果读取EOF时使用非空行，则将其视为新行  

