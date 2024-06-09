## RT-thread --- 创建上下文
**函数**: `rt_hw_stack_init()`  
**实现**:  
- 对`stack_addr`进行对齐处理  
- 初始化传入`包裹函数`的结构体成员  
- 调用`CTE`中的`kcontext()`来创建上下文。  
   - :bulb: <font color=red>该线程的入口，应是包裹函数</font>.这样可以实现，线程返回时，能够调用`texit`来退出线程  
- 返回生成的上下文地址  

### 重点
:bulb: `_thread_init`调用`rt_hw_stack_init()`时传入的参数`stack_addr`是<font color=red>该线程栈空间的end地址</font>  
```c
// 见/src/thread.c中的函数_thread_init()
thread->sp = (void *)rt_hw_stack_init(thread->entry, thread->parameter,
                                          (rt_uint8_t *)((char *)thread->stack_addr + thread->stack_size - sizeof(rt_ubase_t)),
                                          (void *)_thread_exit);
```

#### 包裹函数的实现
```c
// 包裹函数
void thread_wrapper(thread_context_t *context)
{
    if (context && context->tentry) {
        // 调用 tentry
        context->tentry(context->parameter);
    }
    // tentry 返回后，调用 texit
    if (context && context->texit) {
        context->texit();
    }
}
```


## RT-thread --- 切换上下文
**函数**: `rt_hw_context_switch()`,`rt_hw_context_switch_to()`  

> :bulb: 上述函数的参数，是上下文栈指针的<font color=red>地址</font>,而不是地址本身,因此<font color=red>需要解引用</font>  

```c
// scheduler.c中的函数`rt_system_scheduler_start
    /* switch to new thread */
    rt_hw_context_switch_to((rt_ubase_t)&to_thread->sp);
```

<font color=blue>解引用</font>:  
```c
// 将无符号整数类型的 to 转换回 rt_ubase_t* 指针
rt_ubase_t *to_sp_ptr = (rt_ubase_t *)to;
// 解引用指针获取到_thread->sp 的值
rt_ubase_t to_sp_value = *to_sp_ptr;
```

### 如何传递to,from给ev_handler()
1. 通过全局变量: :x:不是一个好办法，当多处理器多线程运行时，会出现问题.  

2. <font color=red>利用线程的私有数据空间</font>，来存储。具体实现如下:
   - 通过`rt_thread_self()`得到当前的线程.(通过阅读源码`rt_system_scheduler_start()`在调用`rt_hw_context_switch_to()`前，对全局变量`rt_current_thread()`赋值尾`to_thread()`.然后他将`to_thread->sp`的地址传送给了`rt_hw_context_switch_to()`  
   - 上述保证了，<font color=purple>当前的线程</font>，为<font color=red>即将要去的线程to</font>.  


