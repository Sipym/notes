# 测试klib
**测试方式**: 将`实际输出`与`预期输出`进行比较  
   - `实际输出`: 由我们编写的库函数输出  
   - `预期输出`: 根据库函数的预期行为而建立  

**分类测试**:  
1. 内存和字符串的<font color=purple>写入函数</font>,例如`memset()`,`strcpy()`等  
2. 内存和字符串的<font color=purple>只读函数</font>,例如`memcmp()`,`strlen()`等  
3. 格式化输出函数，例如`sprintf()`等  

## 内存和字符串的写入函数的测试
**预期行为**: 函数写入区间为[l,r]  
- 第一段是函数写入区间的左侧[0,l), 这一段区间没有被写入, 因此应该有assert(data[i] == i + 1)
- 第二段是函数写入的区间本身[l,r], 这一段区间的预期结果和函数的具体行为有关
- 第三段是函数写入区间的右侧,(r,..) 这一段区间没有被写入, 因此应该有assert(data[i] == i + 1)


## 内存和字符串的只读函数的测试
### 构造预期行为
**预期行为**: 直接构造出函数应该读出的值,然后与实际读出值进行比较  

## 格式化输出函数
### 构造预期行为
**预期行为**: 构造含多个`%d,%s`的测试用例，并得到预期结果，将预期结果与实际输出进行比较  
