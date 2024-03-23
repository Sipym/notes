# 结构体
## 结构体基础知识
### 结构体声明
```cpp
struct tag {
    member-list
    ...
} varialbe-list ;
```
`tag`、`member-list`、`variable-list`这三个部分<font color=purple>至少要出现两个</font>  
`variable-list`是指针型的变量时，<font color=red>不能</font>直接通过`->`访问其成员，<font color=red>必须先令指针指向同一结构体类型的变量</font>  

---
还有一种声明结构的方法,使用 **typedef** 来创建一个类型，如下:  
```cpp
typedef struct {
    int a;
    int b;
    char c;
} Simple;

Simple x;
Simple y[20], *z;
```

#### 结构体定义错误示例
```cpp
typedef struct tag {
   int a;
   Tag *next;//这个是错误地，因为此时typedef还没有生效，即还没有Tag这个类型的变量
   struct tag *next;// 这个才是正确的
}Tag;
```

### 结构成员的访问
直接访问: 使用符号`.`  
间接访问: 使用符号`->`,左操作符<font color=red>必须是指向结构的指针</font>  

### 结构的自引用
在一个结构体内部包含一个类型为该结构本身的成员是<font size=5>非法的</font>。  

在一个结构体内部包含一个<font color=blue>指向该结构体本身的指针</font>是<font size=5>合法的</font>  
```cpp
struct SELF_REF2 {
    int     a;
    struct  SELF_REF2 *b;
    int     c;
};
```
>> 该种结构通常是用于实现链接和树，每个结构指向链表的下一个元素或树的下一个分枝  

### 不完整声明
当必须声明一些相互直接存在依赖的结构时，便使用这种 **不完整声明**(声明一个作为结构标签的标识符)  
```cpp
struct B;

stuct A {
    struct B *partner;
    /* 其他声明 */
};

struct B {
    struct A *partner;
    /* 其他声明 */
}
```

### 结构体的初始化
一个位于一对花括号内部、由逗号分割的初始值列表可用于结构体各个成员的初始化  
```cpp
struct INIT_EX {
    int     a;
    short   b[10];
} x = {
        10,
        { 1, 2, 3, 4, 5 }
};

struct INIT_EX1 {
    int     a;
    short   b[10];
} x = {
        .a = 10,
        .b = { 1, 2, 3, 4, 5 }
};
```


## 作为函数参数的结构
把结构作为参数传递给一个函数，是不太适宜的。  
> 因为这回占用过多的空间，从而影响了效率  
> 所以<font color=red>通常把指向结构的指针作为参数</font>  

### 指向结构的指针作为函数参数
<font color=blue>提高了效率</font>,因为指针比整个结构要小很多  

函数<font color=purple>能够直接</font>对调用程序的<font color=purple>结构变量进行修改</font>  

不希望改变指针指向的结构的值时，可以函数中<font color=purple>使用const修饰参数</font>来防止修改  

```cpp
struct A {
    int a;
    int b;
};

void Recept_struct ( A *a_test) {
    *a_test.a = 1;
}

```














