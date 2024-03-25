# 介绍

`strtok`,`strtok_r`:<font size=5>从字符串中提取tokens(标记...)</font>   

--- 

<font size=5>格式</font>:   
```cpp
char *strtok(char *str, const char *delim);
char *strtok_r(char *str, const char *delim, char **saveptr);
```

<font size=5>功能</font>: 将一个字符串分解成0个或多个非空标记的序列  

---


`delim`参数: 指定了一组字节，用于<font size=5>`分隔`</font>解析字符串中的<font size=5>标记</font>。调用者可以在解析同一字符串的连续调用中在`delim`中指定的不同字符串  

---

在<font size=5>第一次调用</font>`strtok()`时，要解析的字符串应该在`str`中指定。  
在接下来的每个<font size=5>解析相同字符串</font>的调用时，<font color=red>`str`必须为`NULL`</font>  

---

## 一个指针-strtok()的返回值的原理

对<font color=purple>同一个字符串</font>进行操作的strtok()调用序列<font size=5 color=red>维护了一个指针</font>，该指针确定从哪个点开始搜索下一个标记  

第一次调用`strtok()`使得该`指针`指向字符串的第一个字节  
> 下一个`标记的开始`是通过向后扫描str中的下一个`非分隔符`字节来确定的  
>> 如果<font color=blue>找到</font>一个这样的字节,则将其作为下一个标记的开始  
>> 如果<font color=blue>没找到</font>这样的字节，则表示`之后不再有标记`，并且`strtok()`将返回`NULL`  
>>> 字符串如果<font color=blue>为空</font>或者<font color=blue>只含有分割符</font>，将导致`strtok()`在第一次调用时就返回`NULL`  


---

<font color=blue>两个或多个连续</font>的分隔符会被`看成一个`分隔符.  
位于<font color=blue>开头或末尾</font>的分隔符将会被<font color=blue>忽略</font>。  
> 例子:给一个字符串"aaa;;bbb,"，连续调用`strtok()`指定分隔符";,"将返回字符串"aaa"和"bbb"然后返回一个空指针。  

# 返回值
`strtok()`和`strtok_r()`返回一个<font color=purple>指向下一个标记</font>的指针，或<font color=red>NULL</font>(当没有更多标记时)  



# strtok和strtok_
`strtok_r()`函数是`strtok()`的在重入版本。  
`saveptr`参数是一个指向char *变量的指针，strtok r()<font color=red>在内部使用</font>该变量，为了在解析相同字符串的<font color=blue>连续调用</font>之间<font color=red>保持上下文</font>.  
在某些实例中，`saveptr`的值在第一次调用`strtok_r`被要求是`NULL`  

# 注意点
1. 这些函数修改他们的第一个参数  
2. 这些函数不能使用字符串常数  
3. 分隔符将会被丢弃  
4. `strtok()`函数在分析时使用一个静态缓存区，因此他不是线程安全的。 
    如果这个比较重要,就使用`strtok_r()`  


# 使用实例，见手册  
