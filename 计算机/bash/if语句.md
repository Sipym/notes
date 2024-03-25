# if语句
**if语句语法**:  
```bash
if [ expression ];  
then  
    statements  
fi
```

---
**if-else语法**: 
```bash
if [condition];
then
    <if block commands>
else
    <else block commands>
fi
```

---
**else-if(elif)语法**:  
```bash
if [ condition ];  
then  
    <commands>  
elif [ condition ];  
then  
    <commands>  
else  
    <commands>  
fi

```


## 条件选项
|  操作符  |  描述  |
|  ----  |  ----  |
| `! expression` | 检查`expression`是否为假 |
| `-n STRING` | 检查`STRING`的茶馆难度是否大于0 |
| `-z STRING` | 检查`STRING`的长度是否为0,即为空 |
| `str1 == str2` | 检查`str1`是否与`str2`相等 |
| `str1 != str2` | ... |
| `integer1 -eq integer2` | 检查`integer1`在数值上是否等于`integer2` |
| `integer1 -gt integer2` | 检查`integer1`在数值上是否大于`integer2` |
| `integer1 -lt integer2` | 检查`integer1`在数值上是否小于`integer2` |
| `-d file` | 检查`file`是否存在并且他是一个目录 |
| `-e file` | 检查`file`是否存在 |
| `-r file` | 检查`file`是否存在,并授予读取权限 |
| `-s file` | 检查`file`是否存在并其大小大于0 |
| `-w file` | 检查`file`是否存在并授予写权限 |
| `-x file` | 检查`file`是否存在并授予执行权限 |
| `-f file` | 检查`file`存在且是一个普通文件则返回为真 |


