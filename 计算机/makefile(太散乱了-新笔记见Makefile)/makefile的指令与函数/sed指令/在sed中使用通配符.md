# 如要匹配任意的.c文件则需:
    - 用\($*\)\.c即可
        - 实例： sed 's,\($*\)\.c,\1.o,g'
            - 表示将所有的.c文件替换成.o文件
