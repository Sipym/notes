assert 是一个宏，其原型定义在assert.h中  
作用: 用于检测它的条件，如果错误，则终止程序进行  

# 注意事项和用法总结
## 注意事项
1. 每个assert语句之检验一个条件  
2. 不能在assert语句中使用改变环境的语句，因为assert只在DEBUG个生效,如果这么做,会使用程序在真正运行时遇到问题,如
    - 错误：`assert(i++ <100);`  
    - 正确：`assert(i<100); i++;`
3. assert 语句应该与后面的语句空一行  

## 用法总结
### 在函数开始出检验传入参数的合法性  
```cpp
int reset(int nNewSize)
{
    assert(nNewSize >= 0);
    assert(nNewSize <= MAX_BUFFER_SIZE);
}
```
