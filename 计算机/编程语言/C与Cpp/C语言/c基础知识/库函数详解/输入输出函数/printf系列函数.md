# 家族成员
```cpp
#include <stdio.h>

int printf(const char *format, ...);
int fprintf(FILE *stream, const char *format, ...);
int dprintf(int fd, const char *format, ...);
int sprintf(char *str, const char *format, ...);
int snprintf(char *str, size_t size, const char *format, ...);

#include <stdarg.h>

int vprintf(cons char *format, va_list ap);
int vfprintf(FILE *stream, const char *format, va_list sp);
int vdprintf(int fd, condt char *format, va_lists ap);
int vsprintf(char *str, const char *format, va_list ap);
int vsnprintf(char *str, size_t size, const char *format, va_list ap);
```

## 介绍
`printf`, `vprintf`: 写输出到stdout流  
`fprintf`, `vfprintf`: 写输出到指定的流(在函数中的stream参数指定)  
`sprintf`, `snprintf`, `vsprintf`, `vsnprintf`: 将<font color=purple>输出写到字符串`str`</font>中。  

---
`dprintf`: 类似于`fprintf`,只是dprintf的输出是写入文件`fd`中。  

---
`snprintf`, `vsnprintf`: 写入最大为`size`字节(包括了结尾符`\0`)的字符串到`str`  

---

关于带v的printf函数的区别，到时候再看手册

# 返回值
**成功**: 返回打印字符的数目，不包括`'\0'`  
**失败**: 返回 `负数`  

