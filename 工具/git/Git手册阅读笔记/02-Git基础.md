# Git 基础

## 获取git仓库
- `git init`: 初始化一个git仓库  
- `git clone`: 克隆一个现有的仓库  

## git status 检查当前文件状态
**git status输出有以下三种比较重要的信息:**  
- `Untracked files`:  列出了当前仓库未跟踪的文件  
- `Changes to be committed`: 列出了已暂存(等待提交)的文件  
- `Changes not staged for commit`:  列出了发生改变了的已跟踪文件  


> 其他用法: `git status -s` 显示简略的状态信息。分为两栏输出，左栏指明了暂存区的状态，右栏指明了工作区的状态  


## 忽略文件.gitignore
**重要语法与规则如下**:  
- 可以使用标准的<font color = blue>glob模式匹配</font>,并且<font color = red>递归应用在整个工作区</font>。  
- `/`开头,<font color = red>防止递归</font>  
- `/`结尾，指定目录  
- `!`开头，相当于取反  
- `**`,表示匹配任意中间目录  
- <font color = red>规则存在冲突的，上面的会被下面的覆盖</font>。


## git rm 移除文件
**功能**: 从<font color = purple>已跟踪文件清单</font>中移除指定文件。  

`git rm`: 直接将文件从<font color = blue>已跟踪清单</font>&<font color = blue>当前工作区</font>中删除  
`git rm --cached XX`: 从跟踪清单中删除某个文件，但<font color = blue>保留在当前工作目录</font>  
`git rm -f XXX`: 已经在暂存区的文件或已修改的文件，需要添加-f选项来强制删除  


**使用的好处**: 保证操作的一致性，并避免了手动运行`git add`的步骤(可能存在删除记录没有被跟踪;或者删除记录的commit与实际commit不一样,因为<font color = red>手动删除的文件，需要git add/rm来跟踪删除记录</font>)，减少出错的机会。

## git mv 移动文件&重命名
`git mv file_from file_to`  


## git commit --amend 撤销操作
**功能**: 当上一次提交漏了几个文件时，可以通过这个命令来代替第一次提交的结果; 也可以用来修改提交信息  

## git reset HEAD files 取消暂存的文件
**功能**: 取消已暂存的文件  

## git checkout -- files 撤销对文件的修改
**功能**: 将文件恢复到上一次提交的状态。


