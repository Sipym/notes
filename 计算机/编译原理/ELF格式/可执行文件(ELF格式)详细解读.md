# ELF文件详细解读
## ELF文件中相关概念
**SHT_PROGBITS**: 表示`section` 包含程序定义的信息，如代码或数据。  
**SHF_ALLOC**: 表示这个`section`包含在进程的内存映像中是分配的。(当程序被加载到内存中执行时，这个section会占用内存空间  
**SHF_WRITE**: 表示这个`section`是可写的  

## 程序头表 Program Header 
```
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           RISC-V
  Version:                           0x1
  Entry point address:               0x80000000
  Start of program headers:          64 (bytes into file)
  Start of section headers:          6688 (bytes into file)
  Flags:                             0x4, double-float ABI
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         3
  Size of section headers:           64 (bytes)
  Number of section headers:         10
  Section header string table index: 9
```


## Section Headers
内容: 包含程序中各个节(section)的`元数据信息`(名称，大小，<font color=green>偏移量</font>,权限(读写执行)等)  
   - `偏移量`: 如可用于在elf的十六进制文件中查找其存储的数据  

### .text
节内容: 包含程序的可执行机器指令  

---
### .rodata (read only data)
节内容: 包含只读数据，如`常量字符串`  

---
### .data
节内容: 该部分保存有助于程序内存映像的初始化数据。该部分的类型为 `SHT_PROGBITS`。属性类型为 `SHF_ALLOC` 和 `SHF_WRITE`  

---
### .bss
节内容: <font color=reg>该部分保存为初始化的全局变量和静态变量</font>，根据定义，当程序开始运行时，系统将数据初始化为零。该节的类型为 `SHT_NOBITS`。属性类型为 `SHF_ALLOC` 和 `SHF_WRITE`  


---
### .comment
节内容: 包含编译器和编译选项的注释信息

---
### .symtab
节内容: 包含程序的`符号表`，存储了程序中的符号信息

---
### .strtab
节内容: 包含字符串表，存储了ELF文件中使用的各种字符串(<font color=blue>除了常量字符串</font>)
   - > <font color=purple>符号名称</font>，符号表中的字符串等  

---
### .shstrlab
节内容: 包含节头部字符串表，存储了节的名称  

---
### .riscv-attributes
节内容: 包含了risc-v指令集架构的特定属性信息  

---
## Symbol Table 符号表
<font color=red>功能</font>:  

