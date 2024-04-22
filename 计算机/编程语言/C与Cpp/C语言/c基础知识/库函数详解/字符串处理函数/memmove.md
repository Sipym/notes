# memmove - copy memory area
```c
void *memmove (void *dest, const void *src, size_t n);
```
**功能**: 从`src`复制`n`字节的数据到`dest`  
**具体功能实现**: 将`src`复制到一个不与`src,dest`重叠的内存区域的临时数组中，然后从临时数组赋值数据到`dest`  
**要求**: 内存区域<font color=purple>可能重叠</font>  
**返回值**: 返回一个指向`dest`的指针  

