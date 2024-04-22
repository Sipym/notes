# strcat,strncat -  连接两个字符串
```c 
char *strcat(char *dest, const char *src);
char *strncat(char *dest, const char *src, size_t n);
```
## strcat
**功能**: 将`src`字符串添加到dest字符串的后面，并在末尾添加'\0'  
**要求**: 字符串`may not`重叠，`dest`字符串必须足够大  
   - > 当`dest`不够大时，程序的行为是不可预测的  

## strncat
**功能**: 如果`src`字符串包含`n个以上`字节，`strncat()`将写`n+1`(包括'\0')字节到`dest`字符串  
