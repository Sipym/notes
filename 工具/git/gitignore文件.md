# .gitignore
一般了我们总有一些文件无需纳入git的管理，也不希望他们出现在未跟踪文件列表。  
可以通过创建一个名为`.gitignore`的文件，列出要忽略的文件的模式  

## 格式规范
- 所有空行或者<font color=red>以#开头</font>的文件都会被Git忽略(相当于注释)  
- 可以使用标准的<font color=blue>正则表达式</font>匹配，他会递归的应用在整个工作区中.  
    - ** 可以表示匹配任意中间目录，如a/**/b 可表示为 a/z/b , a/b , a/c/d/b,...
- 匹配模式可以用以 / `开头`<font color=red>防止递归</font>  
    - /TODO,表示只忽略当前目录下的TODO文件，而不忽略subdir/TODO文件  
- 匹配模式可以用以 / `结尾`<font color=red>指定目录</font>  
    - build/ 表示忽略任何目录下名为build的文件夹  

## .gitignore文件参考网址  
GitHub 有一个十分详细的针对数十种项目及语言的 .gitignore 文件列表， 你可以在 https://github.com/github/gitignore 找到它。

## .gitignore应用实例
```.gitignore
# 忽略所有的 .a 文件
*.a

# 但跟踪所有的 lib.a，即便你在前面忽略了 .a 文件
!lib.a

# 只忽略当前目录下的 TODO 文件，而不忽略 subdir/TODO
/TODO

# 忽略任何目录下名为 build 的文件夹
build/

# 忽略 doc/notes.txt，但不忽略 doc/server/arch.txt
doc/*.txt

# 忽略 doc/ 目录及其所有子目录下的 .pdf 文件
doc/**/*.pdf
```
