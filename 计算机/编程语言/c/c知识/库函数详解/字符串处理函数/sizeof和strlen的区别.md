`strlen`函数用来求字符串的长度，但<font color=red>不包括结束字符</font>。  
`sizeof`用来求指定变量或变量类型所占内存大小。  

---

# 使用sizeof来求得数组中的元素数目：  
```cpp
char *a[] = {"ab", "da", "cd", "da", "aa"}
int a_num = sizeof(a)/sizeof(a[i]);
```
<font color=red>前提是数组中各个元素的大小相等</font>。  
