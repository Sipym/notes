# strchr,strrchr,strchrnul - 确定字符串中某字符的位置  
```cpp
#include <string.h>

char *strchr(const char *s, int c);

char *strrchr(const char *s, int c);

#define _GNU_SOURCE         /* See feature_test_macros(7) */
#include <string.h>

char *strchrnul(const char *s, int c);
```

## 介绍
`strchr()`: 返回字符串`s`中出现的第一个字符`c`的指针  

`strrchr()`: 返回字符串`s`中出现的最后一个字符`c`的指针  

