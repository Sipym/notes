```cpp
#include <sys/time.h>

int gettimeofday(struct timeval *tv, struct timezone *tz);

int settimeofday(const struct timeval *tv, const struct timezone *tz);
```
# 介绍
`gettimeofday()`和`settimeofday()`能获取或设置时间和时区。  
**通过把结构体tv传入来实现改变或设置时间的作用**。  

## tv参数
```cpp
struct timeval {
    time_t      tv_sec;     // 秒
    suseconds_t tv_usec;    // 微秒
```
`tv`参数的类型是结构体`timeval` ，并给出自Epoch以来的秒和微秒  

## tz参数
```cpp
struct timezone {
    int tz_minuteswest;     //minutes west of Greenwich
    int tz_dstime;          //type of DST correction
```

---
如果`tv`或`tz`为NULL，则不设置或返回相应的结构。(但是，如果<font color=blue>tv为NULL</font>，则会产生<font color=red>编译警告</font>)  

`timezone`结构体的使用已经被舍弃，参数`tz`通常指定为NULL  


# 返回值
返回0表示成功，返回-1表示失败。  

# 注意点
`gettimeofday()`返回的时间会受到系统时间不连续跳变的影响(例如，如果系统管理员手动更改了系统时间
