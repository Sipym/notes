# 第一种
```makefile
subsystem:      
    cd subdir && $(MAKE)
或者
subsystem:
    $(MAKE) -C subdir
```

# 第二种
- 将命令$(MAKE) -C subdir添加到某个目标中
    - 常放在最终目标 或者 subsystem下
    - 使用这个命令的时候，make的-w参数会自动被添加
        - 参数中有-s,--no-print-directory时，-w总是实效的
