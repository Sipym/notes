# strcpy,strcnpy - 复制字符串
```cpp
#include <string.h>

char *strcpy(char *dest, const char *src);

char *strncpy(char *dest, const char *src, size_t n);
```

## 功能介绍
strcpy() 函数复制`src`指向的字符串(包括终止字符)到`dest`指向的缓冲区  
字符串不能重叠，并且目标字符串dest必须足够大以接收副本  

## 返回值
返回一个指向目标字符串`dest`的指针  

## 注意事项
不要在指针声明时使用，应该先给指针分配一个空间  
