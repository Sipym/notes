# vim补全实现
[参考链接](https://vim.fandom.com/wiki/Dictionary_completions#:~:text=With%20this%20mapping%2C%20when%20in,P%20for%20the%20previous%20word.)
1. 添加字典文件路径给`dictionary`  
   > `set dictionary+=路径`
2. 插入模式下，按下<C-x><C-k>可进入补全模式  
   > <font color=red>通过`set complete+=k`可以省去该步</font> 
3. 通过<C-N>,<C-P>来切换选择补全项  

---
## 为特定文件添加字典
<font color=purple>通过自动命令完成</font>  
如下:  
```vim
  autocmd BufEnter *.md :set complete+=k
  " 为markdown添加补全字典
  autocmd BufEnter *.md :set dictionary+=/home/awjl/1.txt
```

