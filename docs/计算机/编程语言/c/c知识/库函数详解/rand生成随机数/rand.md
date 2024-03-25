# 随机数
```cpp
#include <stdlib.h>

int rand(void);
int rand_r(unsigned int *seedp);
void srand(unsigned int seed);
```
rand(): 返回一个伪随机数，由srand设置的种子决定(即若不更改种子,rand每次返回的值都是一样的)  

srand(): 将其参数设置为rand返回的伪随机整数新序列的种子,通过使用相同的种子值调用srand()，这些序列是可重复的  

综上,因此通常使用time()函数来作为srand的参数,如`srand(time(0))`  


