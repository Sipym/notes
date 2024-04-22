# inline assembly
[官方文档](https://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html)  
## 内联inline
**作用**:指示编译器<font color=purple>将函数的代码插入到其调用者</font>的代码中，直到实际进行调用的位置,`类似宏`  
**内联函数意义**: 能够减少函数调用的开销  
```c
inline returnType functionName(parameters) {
    // 函数体
}
```

## GCC汇编器语法
GCC(the GNU C Compiler for Linux), 使用`AT&T/UNIX`汇编语法  
1. `Op_code  src dst`  
2. `寄存器名字`: 以`%`为前缀  
3. `立即操作数`: 以`$`开头，示例如下:  
   - `$0x11`  
4. `操作数大小`: 通过<font color=purple>后缀</font>`b(byte,8-bit)`,`w(word, 16-bit)`,`I(long,32-bit)`    
5. `内存操作数`: 基址寄存器包含在`()`中  
   - 间接内存引用: `disp(base、index、scale)`  

## 基本内联汇编
**基本内联汇编格式**:  
```c
asm("assembly code")  
__asm__("assembly code")  
```
**实例**:  
```c
 __asm__ ("movl %eax, %ebx\n\t"
          "movl $56, %esi\n\t"
          "movl %ecx, $label(%edx,%ebx,$4)\n\t"
          "movb %ah, (%ebx)");
```
