# 介绍
`strcmp`,`strncmp` : 比较两个字符串  
---
<font size=4 color=blue>格式</font>:
```cpp
#include <string.h>
int strcmp(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, size_t n);
```
---
`strcmp()`函数返回一个整数，表示比较的结果。  
- 0: s1和s2相等
- 一个负值: s1 小于s2  
- 一个正值: s1 大于s2  
---
<font color=red>比较的形式</font>:  
从头开始1位1位进行比较，若第一位的ASCII码相等，则比较下一位，如此往复。  

## strncmp()
`strncmp()`的功能和`strcmp()`相似，除了strncmp()函数只比较字符串s1,s2的前n位  
