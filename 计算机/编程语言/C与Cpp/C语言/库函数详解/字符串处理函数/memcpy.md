# memcpy - copy memory area
```c
void *memcpy (void *dest, const void *src, size_t n);
```
**功能**: 从`src`复制`n`字节的数据到`dest`  
**要求**: <font color=purple>内存区域不能重叠</font>,如果内存重叠，使用`memmove()`  
**返回值**: 返回一个指向`dest`的指针  


