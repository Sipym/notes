# memcmp - 比较内存区域
```c
int memcmp(const void *s1, const void *s2, size_t n);
```
**功能**: memcmp() 函数比较内存区域 s1 和 s2 的前 n 个字节（<font color=purple>每个字节解释为无符号字符</font>)

**返回值**: 
- `0`: s1和s2相等; <font color=purple>n为0时，返回值也是0</font>  
- `一个正值`: 结束前的一次比较(记做s[n]),s1[n] 大于s2[n]  
- `一个负值`: 结束前的一次比较(记做s[n]),s1[n] 小于s2[n]  

