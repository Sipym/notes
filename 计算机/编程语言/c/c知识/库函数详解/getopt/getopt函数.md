```c
int getopt(int argc, char * const argv[],
            const char *optstring)

extern char *optarg;
extern int optind, opterr, optopt

int getopt_long(int argc, char * const argv[],
            const char *optstring,
            const struct option *longopts, int *longindex)

int getopt_long_only(int argc, char * const argv[],
            const char *optstring,
            const struct option *longopts, int *longindex);
```

# getopt()
<font size=5 color=purple>`argc`和`argv`</font>: 是在程序调用时传递给`main()`函数的参数计数和数组  
> `argv`中以`-``--`开头的都是选项元素，选项元素中除了`-`都是选项字符  

<font size=5 color=purple>`getopt返回值`</font>: 当getopt被反复调用时，将依次从每个选项元素中返回每个选项字符  
> 如果getopt()发现了其他的选项字符，将返回这个字符，并且更新外部变量`optind`和静态变量`nextchar`,然后继续getopt()对选项字符或argv参数的扫描  

> 如果不再有选项字符,<font color=red>getopt()将返回`-1``</font>,然后<font color=purple>`optind`的值将是`argv`的第一个不是选项字符的元素的索引</font>  


<font size=5 color=purple>`optind`</font>: 是`argv`要处理的下一个元素的索引,系统初始化其值为1  
> 我认为原因是: argv[0]的值是程序执行时的路径，所以跳过了该值。  


<font size=5 color=purple>`optstring`</font>: 是包含合法选项字符的字符串  
> 如果一个字符后面跟着一个冒号`:`,这个选项需要一个参数  
>> 因此getopt()将一个指针放在同一个argv-element中的下一个文本，或者在optarg中放置下一个argv-element的文本

> 如果选项后有文本，则会将文本放在optarg中，否则文本为空  

> 两个冒号表示一个选项接受一个可操作参数  


---

默认情况下，getopt()在扫描argv时对其内容进行排序，因此最终所有`非选项`都位于末尾  

---

<font color=purple>getopt()能发现两种错误</font>:  
1. 不是`optstring`中的字符  
2. 需要参数时，却没有参数  

<font color=purple>错误处理</font>：  
- 默认，getopt()在标准错误上打印错误消息，将错误选项字符放在`optopt`中，并<font color=red>`返回值?`</font>作为函数的结果  
- 如果调用者将全局变量`opterr`设置为零，则getopt()**不会打印错误消息**。调用者可以通过测试函数返回值是否为'?'来确定有错误。
- 如果optstring的第一个字符(前面描述的任何可选'+'或'-'之后)是<font size=5>冒号(':')</font>，那么getopt()同样<font color=red>不会打印错误消息</font>。此外，它返回':'而不是'?，表示缺少一个选项参数。这允许调用者区分两种不同类型的错误

# getopt_long()和getopt_long_only()
getopt_long()工作和getopt()类似，<font size=5>除了它还接受长选项(以`--`开头的)</font>  
`Longopts`是指向<getop .h>中声明的struct option数组的<font size=5>第一个元素</font>的指针  

## struct option各个成员详解  
```c
struct option {
    const char *name;
    int         has_arg;
    int        *flag;
    int         val;
};
```
`name`: 是长选项的名字  
`has_arg`:   
    - 如果选项不带参数，则为`0`或`no_argument`  
    - 如果选项接受参数，则为`1`或`required_argument`  
    - 如果选项接受一个可选参数，则为`2`或`optionnal_argument`  
`flag`: 指定如何返回长选项的结果  
    - 如果flag = NULL,则`getopt_long()`返回`val`(val也是option结构体的成员)  
    - 否则，`getopt_long()`返回`0`,flag指向一个变量，如果找到该选项，该变量将被设置为`val`，如果没有找到该选项，则保持不变
`val`: 是要返回的值，或load into the variable pointed to by `flag`  

tip: <font color=red>`struct option table[]`该数组的最后一个元素必须`用0填充`</font>  
```c
  const struct option table[] = {
    {"batch"    , no_argument      , NULL, 'b'},
    {"log"      , required_argument, NULL, 'l'},
    {"diff"     , required_argument, NULL, 'd'},
    {"port"     , required_argument, NULL, 'p'},
    {"help"     , no_argument      , NULL, 'h'},
    {0          , 0                , NULL,  0 },
  };

```

`getopt_long`和`getopt_long_only`类似，但“-”和“——”可以表示长选项。如果以“-”(不是“——”)开头的选项不匹配长选项，但匹配短选项，则将其解析为短选项  

# 返回值
如果成功找到选项，则getopt()`返回选项字符`。  
如果所有命令行选项`都已解析`，则getopt()`返回-1`。  
如果getopt()遇到`不在optstring中的选项字符`，则`?`返回。  
如果getopt()遇到一个`缺少参数`的选项，则返回值取决于optstring中的第一个字符:如果它是':'，则返回':';否则”?返回。  









```
