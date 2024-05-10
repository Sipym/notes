# filter函数
1. 一个示例
``` makefile
files = foo.elc bar.o lose.o

$(filter %.o,$(files)): %.o: %.c
    $(CC) -c $(CFLAGS) $< -o $@

$(filter %.elc,$(files)): %.elc: %.el
    emacs -f batch-byte-compile $<
```

2. 功能解释：
- $(filter %.o,$(files))表示调用Makefile的filter函数，过滤“$files”集，只要其中模式为“%.o”的内容。
- **即目标中舍去了foo.elc文件**


3. 使用格式：
$(filter “我需要的模式”,"要过滤的模式")
