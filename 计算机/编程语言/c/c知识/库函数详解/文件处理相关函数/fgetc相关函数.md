# fgetc,fgets,getc,getchar,ungetc - 字符和字符串的输入
```cpp
#include <stdio.h>

int fgetc(FILE *stream);

char *fgets(char *s, int size, FILE *stream);

int getc(FILE *stream);

int getchar(void);

int ungetc(int c, FILE *stream);
```

## 介绍
`fgetc()`从流中读取下一个字符，并将其作为unsigned char类型转换为int类型，或文件或错误结束时的EOF类型返回  

---

`getc()`相似于`fgetc()`,不同的是它可以被实现为一个宏，对流进行多次计算  

---

`getchar()`等价与`getc(stdin)`  

---

`fgets()`: 从流中读取最多一个小于size的字符，并将它们<font color=purple>存储到s指向的缓冲区</font>中。
读取在EOF或换行符后停止,如<font color=red>读取到换行符，则将其存储到缓冲区中</font>中
  
一个终止空字节`'\0'`存储在缓冲区的最后一个字符之后  

---

## 返回值
**fgetc()** **getc()** **getchar()** 返回作为无符号字符强制类型转换为int类型的字符，或者遇到文件末尾/错误的`EOF`  
**fgets()** 成功时返回`s`, 错误时返回`NULL`，或者文件结束时没有读取任何字符  

