# find
## -exec参数使用
`-exec command ;`  
分号`;`前要带一个反斜杠`\`  

**实例**: `find . -name '*.c' -exec echo {} \;`  
find在当前目录找到符合*.c的文件  
`{}`:表示所有找到的文件  
对所有找到的文件执行`-exec`后的命令直到遇到`;`  
