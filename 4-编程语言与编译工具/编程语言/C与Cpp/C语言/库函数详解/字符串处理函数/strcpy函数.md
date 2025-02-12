# strcpy,strcnpy - 复制字符串
```cpp
#include <string.h>

char *strcpy(char *dest, const char *src);

char *strncpy(char *dest, const char *src, size_t n);
```

## 功能介绍
strcpy() 函数复制`src`指向的字符串(包括终止字符)到`dest`指向的缓冲区  
字符串不能重叠，并且目标字符串dest必须足够大以接收副本  
> <font color=purple>库函数没有实现`重叠检测`，因此出现重叠时，结果可能不符合预期</font>  
>> 若想<font color=purple>避免非预期结果</font>，可以使用`memmove()`函数

## 返回值
返回一个指向目标字符串`dest`的指针  

## 注意事项
不要在指针声明时使用，应该先给指针分配一个空间(<font color=purple>可以通过定义字符数组来实现</font>)  

## 使用须知
1. 使用指针定义字符串时，`dest`需要使用malloc分配足够大的空间，才有读写权利  
2. 可以使用字符数组`char name[Num]`作为`dest`，注意`Num`需要大于等于`src`的长度  

