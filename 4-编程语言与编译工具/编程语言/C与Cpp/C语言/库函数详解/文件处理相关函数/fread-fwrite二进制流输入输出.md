# fread,fwrite-二进制流输入输出
```cpp
 #include <stdio.h>

size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream);
size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);
```

## 介绍
`fread()`从`stream`指向的流中读取`nmemb`项数据，每个数据项长度为`size`,并将它们存储在`ptr`给出的位置  
`fwrite()`向`stream`指向的流中写入`nmemb`项数据,每个数据项长度为`size`,从`ptr`给出的位置获取这些数据  

## 返回值
如果成功，fread()和fwrite()返回读或写的项数  

如果发生错误，或<font color=purple>到达文件末尾</font>，则返回值为一个短的项计数(或零)  


