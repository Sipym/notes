遇到了bug，iconv无法完整的进行编码转换，通过stfw后发现，当源文件和目标文件一致且文件大小大于32k时便会出现该问题。因此通过更改源文件和目标文件的名称即可解决问题  
[参考网站](https://unix.stackexchange.com/questions/176009/iconv-terminated-by-signal-7)  

