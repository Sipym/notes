# 对列(c实现)
> :bulb: 是一 种<font color=skyblue>先进先出</font>的数据结构  

## 队列的结构设计
**结构组成**: 两个结构体
   - `Node`:表示结点,<font color=purple>属于链表结构</font>  
   - `queue`: 包含两个分别`永远指向`队列的`对尾`和`对头`的指针  

> 元素按照链表的方式构建就行  

**代码实现**:  
```c
//队列的结点设计
//单个结点设计，数据和下一个指针
typedef struct node     
{
    int data; 
    struct node *next;
} Node;
//利用上面的结点创建队列，分为指向头结点的front指针和尾结点rear
typedef struct stack    
{
    Node *front;
    Node *rear;
} queue;
```

**队列初始化**:  
```c
queue *init_queue() {
    queue *q=(queue*)malloc(sizeof(queue));
    if(q==NULL){    //建立失败，退出
        exit(0);
    }
    //头尾结点均赋值NULL
    q->front=NULL;  
    q->rear=NULL;
    return q;
}
```

## 队列的基本操作 -- 入队(push)
![img](img/队列为空时的入队操作.png '图1 队列为空时的入队操作 :size=50%')
![img](img/队列不为空时的入对操作.png '图2 队列不为空时的入对操作 :size=50%')  

**操作方式**: 
- (1): `队列为空`: 需将`头尾指针`<font color=purple>同时指向第一个结点</font>  
- (2): `队列不为空`： 头指针始终指向第一个结点; 尾指针向后移动  

**具体操作流程**:
   1. 创建新结点`new_node`  
   2. 分上面两种情况进行考虑  
   3. 若为(2),让`new_code`成为当前尾结点下一个结点  
   4. 让尾结点指向`new_code`  

```c
void push (queue *q, int data) {
   Node *n = (Node *)malloc(sizeof(Node));
   n->data = data;
   n->next = NULL;
   if (q->front == NULL) {
      q->front = n;
      q->rear = n;
   }else {
      q->rear->next = n;
      q->rear = n;
   }
}
```

## 队列的基本操作 -- 出队(pop)
**操作方式**: 
- (1): `只有一个结点时`: 将头尾指针指向NULL  
- (2): `队列不为空`： 将头指针指向头指针指向的下一个元素  

```c
//出队操作
void pop(queue *q){
    node *n=q->front;
    if(empty(q)){
        return ;    //此时队列为空，直接返回函数结束
    }
    if(q->front==q->rear){
        q->front=NULL;  //只有一个元素时直接将两端指向制空即可
        q->rear=NULL;
        free(n);        //记得归还内存空间
    }else{
        q->front=q->front->next;
        free(n);
    }
}
```

