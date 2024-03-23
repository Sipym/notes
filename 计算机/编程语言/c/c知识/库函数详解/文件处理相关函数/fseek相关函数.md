# fgetps,fseek,fsetpos,ftell,rewind - 重新定位流
```cpp
#include <stdio.h>

int fseek(FILE *stream, long offset, int whence);

long ftell(FILE *stream);

void rewind(FILE *stream);

int fgetpos(FILE *stream, fpos_t *pos);

int fsetpos(FILE *stream, const fpos_t *pos);
```

## 介绍
**fseek()函数**的作用: 为stream所指向的流设置<font color=purple>文件位置指示器</font>。
以字节为单位的 **新位置**是通过向`whence`指定的位置添加偏移字节来获得的。
如果将`whence`设置为`SEEK_SET`,`SEEK_CUR`,`SEEK_END`，则偏移量分别相对于`文件的开始`、`当前位置指示符`或`文件的结束`  

---

**ftell()函数**的作用: 获取stream指向的流的文件位置指示器<font color=purple>当前值</font>

---

**rewind()函数**的作用: stream指向的流的文件位置指示器设置为文件的开头  
流的错误指示器也被清除  

---

## 返回值
**成功**完成后，fgetpos()， fseek()， fsetpos()返回0,ftell()返回当前偏移量  

否则，返回-1，并设置`errno`表示错误
