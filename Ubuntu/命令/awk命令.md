# awk
可以用来求和...  
## 对文件第一列中的值求和并打印总数
`awk '{s+=$1} END {print s}' path/to/file`  
