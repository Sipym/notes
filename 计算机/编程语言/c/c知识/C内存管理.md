# C内存管理
在C中，内存是通过指针变量来管理的.  

---
<font size=4 color=purple>几个常用的函数</font>  
```cpp
#include <stdlib.h>

void *calloc(int num, int size);
// 在内存中动态地分配num个长度为size的连续空间，并将每个字节都初始化为0.

void free(void *address);
// 释放address所指向的内存块，释放的是动态分配的内存空间  

void *malloc(int num);
// 在堆区分配一块指定大小的内存空间，这块内存空间在函数执行完成后不会被初始化，值是未知的。  

void *realloc(void *address, int newsize);
// 该函数重新分配内存，把内存扩展到newsize 

```

## 动态分配内存
动态的根据变量来定义数组的大小：  
```cpp
char *description;
description = (char *)malloc( N * sizeof(char) ); // N可以为任何整数,char也可以为任意其他类型
```
也可以使用calloc()来编写  
```cpp
description = (char *)calloc(N, sizeof(char));
```


## 重新调整内存的大小和释放内存
当不需要内存时，都应该<font color=blue>调用函数`free()`</font>来<font color=blue>释放内存</font>  
当需要调整内存大小时，调用函数`realloc()`来增加或减少已分配的内存块大小  


