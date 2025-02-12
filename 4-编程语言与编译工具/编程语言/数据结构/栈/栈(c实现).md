# 栈(c实现)
> :bulb: 是一种先进后出的数据结构  

## 栈的结构设计
**结构组成**: 两个结构体
   - `Node`:表示结点,<font color=purple>属于链表结构</font>  
   - `Stack`: 包含一个<font color=red>永远指向栈头(最上面的)的指针top</font>,和`count`(<font color=purple>记录元素个数</font>)  
      - > 也可包括尾指针  

> 因此元素按照链表的方式构建就行  

**代码实现**:  
```c
//栈的结点设计
//单个结点设计，数据和下一个指针
typedef struct node     
{
    int data; 
    struct node *next;
} Node;
//利用上面的结点创建栈，分为指向头结点的top指针和计数用的count
typedef struct stack    
{
    Node *top;
    int count;
} Link_Stack;
```

## 栈的基本操作 -- 入栈(push)
![img](img/栈的基本操作-入栈.png '图2 栈的基本操作-入栈 :size=80%')  
**操作**: 
- (1) 创建一个新的结点;
- (2) 将新的结点的next指针指向top指向的空间;
- (3) 让top指向新结点  

```c
Link_Stack *Push_stack(Link_Stack *p, int elem) {
   if (p == NULL)
      return NULL;

   // (1)temp = new Node;
   Node *temp;
   temp = (Node *)malloc(sizeof(Node));
   // (2) new_node -> top;
   temp->data = elem;
   temp->next = p->top;
   // (3) update top
   p->top = temp;
   p->count++;
   return p;
}
```

##  栈的基本操作 - 出栈(pop)
![img](img/栈的基本操作-出栈.png '图3 栈的基本操作-出栈. :size=80%')  
**前提**: 栈不为空(即count不为0)  
**操作**:  
   - (1) 将<font color=purple>栈顶元素删除</font>,即`top指向的结点`  
   - (2) `top->next`,top下移  

```c
//出栈 pop
Link_Stack *Pop_stack(Link_Stack *p)
{
    Node *temp;
    temp = p->top;
    if (p->top == NULL)
    {
        printf("错误：栈为空");
        return p;
    }
    else
    {
        p->top = p->top->next;
        free(temp);
        //delete temp;
        p->count--;
        return p;
    }
}
```
## 栈的基本操作 - 遍历
**操作**: 从栈顶到栈尾遍历,是逆序的  


