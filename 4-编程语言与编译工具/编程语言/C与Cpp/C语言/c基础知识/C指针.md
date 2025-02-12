# C指针
## 指针的类型
> tip: <font color=red>`[]`的优先级高于`*`</font>，如`*p[3]`会先与`[]`结合、然后再与`*`结合。  

`int p`: p是一个普通的<font color=blue>整型变量</font>  
`int *p`: p是一个指针int型的<font color=blue>指针</font>  
`int p[3]`: p是一个由整型数据组成的<font color=blue>数组</font>。  
`int *p[3]`: p是一个由指向int型数据的<font color=purple>指针组成</font>的<font color=blue>数组</font>。  
`int (*p)[3]`: p是一个指向一个由整型数据组成的数组的<font color=blue>指针</font>。  
`int **p`: p是指向一个`指向整型变量`的<font color=blue>二级指针</font>  

---

<font size=6>函数指针</font>:   
`int p(int)`: p是一个有一个整型变量，返回值是一个整型数据的<font color=blue>函数</font>  
`int (*p)(int)`: p是一个指向有一个整型参数且返回类型为整型的函数的指针  
`int *(*p(int))[3]`: p是一个参数为整型数据且返回一个指针指向整型指针变量组成的数组的指针变量的<font color=blue>函数</font>  

---

### 总结: 
1. p先和[]组合，则p是一个数组  
2. p先和*组合，则p是一个指针  
3. p先和()组合，则p是一个函数  

### 判断指针的类型
方法: 去掉指针声明语句里的指针名字，剩下的部分就是指针的类型。  

### 判断指针指向的类型
方法: 把指针声明语句中的指针名字和名字左边的指针声明符*去掉。  

## 字符串指针
```c
char *b = "HELLO";
```
- `b`: 为该指针的首地址  
- `*b`:为该字符串第一位的值，即`H`  
- `b[0]`: 也是`H`  
- '*(b+1)': 为`E`  
- `(b+1)[0]`: 为`E`  
- 

## void指针
```c
void *name 
```
**使用须知**:  
   - 使用时，需进行强制类型转换(即显示说明这个指针在内存中存放的是什么类型的数据)  
   - <font color=red>GNU在默认情况下,`void *`和`char *`一样</font>  

## 指针的运算 

###  指针的算术运算

####  形式一: 指针 ± 整数
标准定义这种形式<font color=red>只能用于</font>**指向数组中某个元素的指针**。  
```cpp
int a[3] = {1, 2, 3};
int *p = a;//p指向了a的第一个元素
p += 1;
```
对指针p加1使它指向了<font color=blue>数组的下一个元素</font>。  

即p = p+n使得p指向的内存区移动了`n × sizeof(p指向的元素类型)`个字节。  

#### 形式二: 指针 - 指针
只有当两个指针都指向同一个数组的元素时，才允许从一个指针减去另一个指针。  
或者如下情况:  
```cpp
char *str = "HELLO WORLD!";
char *s = str;
s = s + 5; //此时s = " WORLD!"
long ind d = s - str; //此时d = 5;
```

两个指针相减的结果类型是有符号整数类型。  
减法运算的值是两个指针在内存中的距离(<font color=red>以数组元素长度为单位</font>，而不是字节)  
`p1 = array[i],p2 = array[j]`则`p1-p2`的值就是`i-j`  



### 指针的关系运算
前提: 他们都指向同一个数组中的元素。  


## 运算符&和*
&: 是取地址运算符  
*: 是间接运算符  





