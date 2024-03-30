# find
## -exec参数使用
`-exec command ;`  
分号`;`前要带一个反斜杠`\`  

**实例**: `find . -name '*.c' -exec echo {} \;`  
find在当前目录找到符合*.c的文件  
<font color=red>`{}`:表示所有找到的文件</font>  
对所有找到的文件执行`-exec`后的命令直到遇到`;`  

### -exec sh -c '...'
**作用**:  执行一个shell命令  
扩展: 在'...'后面加一个sh,表示将'...'中的shell命令<font color=purple>传给bash来运行</font>(因为find并没有支持所有的shell指令)  


## !参数-排除
`! -name "pattern"`  
> 功能: 排除符合模式的文件或文件夹  

`! -path "pattern"`  
> 功能: 排除符合模式的路径下的文件或文件夹  

## 指定搜索深度
`-mindepth`: 最小层级  
`-maxdepth`: 最深层级  


