# 介绍
```cpp
 #include <regex.h>

int regcomp(regex_t *preg, const char *regex, int cflags);

int regexec(const regex_t *preg, const char *string, size_t nmatch, regmatch_t pmatch[], int eflags);

size_t regerror(int errcode, const regex_t *preg, char *errbuf, size_t errbuf_size);

void regfree(regex_t *preg);
```

---

## POSIX正则表达式模式编译(确定匹配的模式) regcomp()
`regcomp()` 用来<font color=red>用于将正则表达式编译为适合后续`regexec()`搜索的形式</font>  
所以regcomp()函数是非常重要的。  

---

`regcomp()`参数:  
    - <font color=red>`preg`</font>: 指向模式缓冲区存储区域的指针  
    - `regex`: 指向以空结束的字符串,<font size=5 color=red>包含了正则表达式的匹配规则</font>  
    - `cflags`：用于确定编译类型的标志   

所有正则表达式搜索都<font color=red>必须通过已编译的模式缓冲区</font>完成，因此regexec()必须始终提供<font color=blue>regcomp()初始化模式缓冲区</font>的地址  

---

<font size=5>**flags** 是以下零个或多个的按位或(如`cflags = REG_EXTENDED|REG_ICASE`)</font>:  

**REG_EXTENDED**:   
解释正则表达式时使用<font color=purple>POSIX扩展正则表达式语法</font>。如果`未设置`，则使<font color=purple>POSIX基本正则表达式语法</font>用  

**REG_ICASE**:  
<font color=red>不区分大小写</font>。后续的`regexec()`使用这个模式缓冲区时将不会区分大小写。  

**REG_NOSUB**:  
<font color=blue>不报告匹配的位置</font>。  
如果`regexex()`使用由这个flags设置的模式缓冲区，参数`nmatch`、`pmatch`将会被忽略  

**REGE_NEWLINE**:  
使得匹配任意字符的操作符不匹配换行符  
(详细再看看手册)  

---

## POSIX正则表达式匹配 regexec()
**regexec()** 根据模式缓冲区(<font color=red>preg</font>)来匹配一个以空字符结尾的字符串  

---
`nmatch`,`pmatch`: 用于提供<font color=red>有关任何匹配的位置</font>的信息  

--- 
<font size=5>**eflags**是由如下零个或多个标志的按位或</font>：  
**REG_NOTBOL**:  
匹配行首操作符总是匹配失败(但请参阅上面的编译标志REG NEWLINE)。  
当字符串的不同部分被传递给regexec()，并且字符串的开头不应该被解释为行首时，可以使用此标志  

**REG_NOTEOL**:  
匹配行尾操作符总是匹配失败  

**REG_STARTEND**:  
在输入字符串上使用pmatch[0],从字节`pamtch[0].rm_so`开始，到`pmatch[0].rm_eo`结束  
允许匹配嵌入的NULL字节，并且避免在大字符串上使用`strlen`  
不使用`nmatch`输入，并且不改变`REG_NOTBOL`和`REG_NEWLINE`的处理  
这个标志是BSD扩展，不存在与POSIX中  


## 字节偏移量
```cpp
regoff_t off, len;  
```
<font color=purple>除了</font>当为模式缓冲区的编译设置了**REG_NOSUB**时，获得匹配项地址信息是可以的。  

---
`pmatch`的尺寸必须至少有`nmatch`元素  
`pmatch`的值是由`regexec()`填充的，可以<font color=purple>得到子字符串的匹配地址</font>(通过偏移量来得到)  
子表达式从第`i`个开括号开始的<font color=blue>偏移量存储</font>在`pmatch[i]`中  
要返回N个子表达式匹配的偏移量，nmatch必须至少为N+1  

---
任何<font color=blue>未使用</font>的结构体元素将包含值<font color=blue>-1</font>  
```cpp
typedef struct {
    regoff_t rm_so;
    regoff_t rm_eo;
} regmatch_t;
```
任何`rm_so`的值不是-1将<font color=red>表示下一个子字符串(下一个匹配项)的</font>开始偏移量  
`rm_eo`元素表示匹配项的末尾偏移量，即匹配文本后第一个字符的偏移量  

### 字节偏移量应用实例-加深理解
```cpp
    char *str = "HELLO WORLD!";
    static const char* s = str;
    regex_t            regex;
    regmatch_t         pmatch[1];
    regoff_t           off, len;
    if (regcomp(&regex, re, REG_NEWLINE)) exit(EXIT_FAILURE); //用于得到模式缓冲区

    printf("String = \"%s\"\n", str);
    printf("Matches:\n");

    for (int i = 0;; i++) {
        if (regexec(&regex, s, ARRAY_SIZE(pmatch), pmatch, 0)) break;

        off = pmatch[0].rm_so + (s - str); //偏移量
        len = pmatch[0].rm_eo - pmatch[0].rm_so; //通过rm_eo和rm_so可以得到匹配项的长度
        printf("#%d:\n", i);
        printf("offset = %jd; length = %jd\n", (intmax_t)off, (intmax_t)len);
        printf("substring = \"%.*s\"\n", len, s + pmatch[0].rm_so);

        s += pmatch[0].rm_eo; //将字符串已经匹配过的部分移出，为了查看字符串后是否还有匹配项
    }
```

综上所述,<font size=5 color=brown>rm_so和rm_eo可以实现</font>:  
- 确定下一个正则匹配字符串的开始地址和结束地址(即开始偏移量和尾偏移量)   
- 通过相减(rm_eo-rm_so)，可以得到字符串的长度  
- ...

## POSIX错误报告
**regerror()** 被用来将 **regcomp()** 和 **regexec()** 返回的错误代码转换成错误信息字符串  

详细见手册  

# 返回值
regcomp() 返回0表示编译成功，或者一个错误代码表示失败  

regexec() 返回0表示成功匹配， 或者 **REG_NOMATCH** 表示失败  

## regcomp()可返回的错误
**REG_BADBR** : 反向引用运算符的使用无效  
**REG_BADPAT**: 模式操作符(例如组或列表)的使用无效  
**REG_BADRPT**: 无效地使用重复操作符，例如使用'*'作为第一个字符  
**REG_EBRACE**: 不匹配的大括号间隔操作符  
...  



