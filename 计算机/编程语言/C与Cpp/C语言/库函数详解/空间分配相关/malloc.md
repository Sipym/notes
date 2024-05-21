## malloc - 分配动态内存
```c
#include <stdlib.h>

void *malloc(size_t size);
```

### 描述
`malloc`函数用于`在堆上`<font color=purple>分配指定字节数</font>的内存，并返回指向已分配内存的指针。<font color=purple>新分配的内存内容是未定义的</font>。

### 参数
- `size`：需要分配的字节数。

### 返回值
- 成功时，返回指向已分配内存的指针,适合任何内置的类型  
- 如果`分配失败`，返回`NULL`，并<font color=red>设置`errno`为`ENOMEM`以指示内存不足</font>。


### 线程安全性
`malloc`是线程安全的。

### 相关函数
- `free`：释放由`malloc`分配的内存。
- `calloc`：分配并清零内存。
- `realloc`：调整已分配内存的大小。
- `memalign`：分配特定对齐方式的内存。

### 注意事项
- 在使用`malloc`后应检查返回值是否为`NULL`以确保分配成功。
- 分配的内存应在<font color=red>使用完毕后</font>使<font color=red>用`free`函数释放，以避免内存泄漏</font>。
- `malloc`分配的内存内容是未初始化的，可能包含垃圾值。需要使用前进行初始化。

