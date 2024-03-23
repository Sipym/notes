# 自动命令
> [参考资料](http://yyq123.github.io/learn-vim/learn-vi-49-01-autocmd.html)

**定义自动命令**:  
```vim
autocmd  [group] events pattern [nested] command   
```
  - group: 可选项，用于分组管理多条自动命令  
  - <font color=purple>events</font>: 用于指明触发命令的一个或多个事件.  
  - <font color=purple>pattern</font>: 指定符合pattern的文件类型，如*.c  
  - nested: 用于允许嵌套自动命令  
  - command: 需要执行的命令,函数或脚本
    - 要在vim中执行命令，可使用`:!`开头

**定义自动命令组**:  
```vim
augroup 组名
    autocmd! "用于删除之前的自动命令，避免出现冲突
    autocmd ... " 自动命令，自由定义即可
augroup END
```


