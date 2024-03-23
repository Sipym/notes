# for循环
语法:  
```bash
for variable in list
do 
    commands
done
#或
for ((expression1; expression2; expression3))
do
    commands
done
```

---

示例: 
```bash
#!/bin/bash  
#This is the basic example of 'for loop'.  

learn="Start learning from yiibai.com"  

for learn in $learn  
do  
    echo $learn  
done  

echo "Thank You."
//更多请阅读：https://www.yiibai.com/bash/bash-for-loop.html


```
## 注意点
在makefile中使用时，需加续行符  
