1. 基本上都是一样的
2. 我们只需要根据我们的单片机的flash的首地址，ram的大小，flash的大小来计算并更改值即可。要更改的值如下
    - ![è¦改的](img/要改的.png) 
    - 一般只用更改 RAM FLASH 的LENGTH
    - 大部分的__Min_Heap_Size与__Min_Stack_Size是相同的，不需要改变
