# 乱码
原因: win和linux压缩中文的编码不同  
解决: `iconv -f GB2312 -t utf8 1.txt -o 2.txt`  
