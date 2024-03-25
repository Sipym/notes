# 链表
**基本思维**: 利用结构体的设置，额外开辟出一份内存空间去做指针，它总是指向下一个结点，
一个个结点通过NXET指针相互联系，串联，就形成了链表  

解决了数组不方便移动,插入，删除元素的弊端;但付出了更加大的内存牺牲  

使用链表时，传递链表指针时，一定要<font size=4 color=red>切忌指针指向的值是否能够改变</font>  

## 单链表
单链表是一种链式存取的数据结构，链表中的数据以结点来表示  

为了记住链表的起始位置，可以使用一个<font size=5 color=red>根指针</font>(root pointer)  
单链表无法从相反的方向遍历，要回到其他任何结点，只能从根指针<font color=purple>从头开始</font>  

程序在移动到下一个节点前，可以<font color=purple>保存一个指向当前位置的指针</font>，甚至前面几个位置的指针  

头结点的值date都是为0的，合并两链表等情况时应注意  

---
**结点组成**: 元素 + 指针(指向下一个结点)  
<img src="img/单链表的结点结构.png" height="100" width="300" />

> **DATA数据元素**: 可以存储任何数据格式  
> **NEXT为一个指针**: 指向下一个结点(是整个结点，而不是结点中的某个成员), 链表尾部的NEXT指向`NULL`  


### 单链表的结点定义
```cpp
//定义结点类型
typedef struct Node {
    int date;           // 数据类型，可以为任意其他类型
    struct Node *next;  // 指向下一个结点
} Node, *LinkedList;
// Node 表示结点的类型, LinkedList表示指向Node结点类型的指针类型
```

### 单链表的初始化
初始化一般遵从一下格式
```cpp
LinkedList listinit(){
    Node *L;
    L=(Node*)malloc(sizeof(Node));      //开辟空间 
    if(L==NULL){                     //判断是否开辟空间失败，这一步很有必要
        printf("申请空间失败");
        //exit(0);                  //开辟空间失败可以考虑直接结束程序
    }
    L->next=NULL;       //指针指向空
    return L;           //返回初始化后的结点
}
```
<font size=4 color=red>一定要记住判断是否开辟空间失败</font>  

### 创建单链表
利用根指针来记住链表的起始位置  


#### 头插入法
`空表L` **->** `生成新结点` **->** `将新结点作为表头,即使得新结点指向NUll` **->** `生成新结点` **->** `往复循环...`  

生成的结点的次序和输入数据是<font size=4 color=red>不一致的</font>  
```cpp
//单链表的建立1，头插法建立单链表
LinkedList LinkedListCreatH() {
    Node *L;
    L = (Node *)malloc(sizeof(Node));   //申请头结点空间
    L->next = NULL;                      //初始化一个空链表
  
    int x;                         //x为链表数据域中的数据
    while(scanf("%d",&x) != EOF) {
        Node *p;
        p = (Node *)malloc(sizeof(Node));   //申请新的结点
        p->data = x;                     //结点数据域赋值
        p->next = L->next;     //将结点插入到表头L-->|2|-->|1|-->NULL
        L->next = p;
    }
    return L;               // 返回已创建好的链表
}
```

#### 尾插入法
`L头结点,r尾结点(最开始r = L)` **->** `生成新结点N1, L指向N1, r = N1` **->** `生成新结点， N1指向N2， r = N2` **->** `...`

生成的结点的次序和输入数据是<font size=4 color=red>一致的</font>  

```cpp
//单链表的建立2，尾插法建立单链表
LinkedList LinkedListCreatT() {
    Node *L;
    L = (Node *)malloc(sizeof(Node));   //申请头结点空间
    L->next = NULL;                  //初始化一个空链表
    Node *r;
    r = L;                          //r始终指向终端结点，开始时指向头结点
    int x;                         //x为链表数据域中的数据
    while(scanf("%d",&x) != EOF) {
        Node *p;
        p = (Node *)malloc(sizeof(Node));   //申请新的结点
        p->data = x;                     //结点数据域赋值
        r->next = p;            //本质上是将头结点L的next指向了p
        r = p;
    }
    r->next = NULL;
    return L;
}
```

## 单链表的基本操作

### 遍历单链表(打印，修改）

如下是遍历操作(修改操作本质类似，不再阐述):   
```cpp
void printfList （LinkedList L) {
     Node *p=L->next;
    int i=0;
    while(p){
        printf("第%d个元素的值为:%d\n",++i,p->data);
        p=p->next;
    }
}
```

### 链表插入操作
`查找到第i个位置` **->** `将该位置的next指针指向新插入的结点` **->** `新插入的结点的next指向原来的i+1位置的结点`  

需要建立一个<font color=blue>前驱结点</font>，利用循环来找到第i个位置  
```cpp
//单链表的插入，在链表的第i个位置插入x的元素
  
LinkedList LinkedListInsert(LinkedList L,int i,int x) {
    Node *pre;                      //pre为前驱结点
    pre = L;
    int tempi = 0;
    for (tempi = 1; tempi < i; tempi++) {
        pre = pre->next;                 //查找第i个位置的前驱结点
    }
    Node *p;                                //插入的结点为p
    p = (Node *)malloc(sizeof(Node));
    p->data = x;
    p->next = pre->next;
    pre->next = p;
  
    return L;
}
```

### 链表删除操作
建立一个 **前驱结点**(用于找到某个位置),建立一个 **当前结点**,当找到来需要删除的数据时，
直接使用前驱结点跳过要删除的结点指向要删除结点的后一个结点,再将<font color=purple>原有的结点free函数释放掉</font>  

```cpp
//单链表的删除，在链表中删除值为x的元素
  
LinkedList LinkedListDelete(LinkedList L,int x) {
    Node *p,*pre;                   //pre为前驱结点，p为查找的结点。
    p = L->next;
     
    while(p->data != x) {              //查找值为x的元素
        pre = p;
        p = p->next;
    }
    pre->next = p->next;          //删除操作，将其前驱next指向其后继。
    free(p);
     
    return L;
}
```


## 双链表
在单链表的基础上,对每一个结点设计一个前驱结点  
```cpp
typedef struct line {
    int data;
    struct line *pre;
    struct line *next;
}line
```

---
<font color=red>双链表的头结点是与数据元素的</font>  

**头结点的pre指向NULL**  









