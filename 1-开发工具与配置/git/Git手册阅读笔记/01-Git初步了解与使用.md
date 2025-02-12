# Git初步了解与使用
**Git**: <font color = red>分布式版本控制</font>工具  

**Git对待数据的方式**: 将数据看作一系列的快照，唯有当文件发生变化时，才会重新存储该文件，否则只保留一个链接指向之前存储的文件。
![img](img/Git存储项目随时间改变的快照.png '图1 Git存储项目随时间改变的快照 :size=60%')

**Git保证数据的完整性**: Git中所有的数据在存储前都计算校验和，然后以校验和来引用。  

**Git一般只添加数据**: <font color = red>几乎不会执行任何可能导致文件不可恢复的操作</font>。  

**Git状态**:  
   - `已提交(committed)`: 表示修改了文件，还没保存到数据库中  
   - `已暂存(modified)`: 表示<u>对一个已修改文件</u>的当前版本<u>做了标记</u>，使之<font color = blue>包含在下次提交的快照</font>中。  
   - `已修改(staged)`: 数据已经安全地保存在了本地数据库内  

:star:**Git 获取帮助**: 有三种等价的方法可以找到Git命令的综合手册
```bash
$ git help <verb>
$ git <verb> --help
$ man git-<verb>
```

**Git 获取简单的help输出**: `git add -h`  


