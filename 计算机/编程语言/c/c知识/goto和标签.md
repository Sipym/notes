# 标签
## 全局标签
直接使用`lebel:`即可，然后可以通过goto label;来跳转到指定标签  
```c
//实例
int main() {
    goto label1;
    while (0) {
        label1:
        printf("Hello World!\n");
    }
}
```
执行程序后，可以看到输出`Hello World`  

## 局部标签
只能用于局部块中  
<font size=5>局部标签声明</font>:
```c
__label__ label;
__label__ label1, label2, /* ... */;
```

---
**局部标签声明必须定义在块的开头**  

标签声明定义标签名称，但不定义标签本身  
> 必须在某一位置<font color=purple>添加语句</font> `label:`,这个就是标签本身  

---
局部标签功能对于复杂的宏很有用，如果宏包括嵌套循环，则可以用goto打破他们，但是，不能使用范围为整个函数的普通标签。  
> 因为如果宏可以在一个函数中展开多次，则该标签在该函数中被多次定义。本地标签避免了这个问题。

