# ELF文件解析
> :bulb: `man 5 elf`  

**elf** - 可执行文件和链接格式 (ELF) 文件的格式  

## <elf.h>
**内容1**: 定义了ELF中`可执行二进制文件`的`格式`: `常规可执行文件`，`可重定向目标文件`，`核心文件`，`共享对象`等  
**内容2**: <font color=green>以C结构的形式</font>，描述了`ELF header`，`动态节`，`重定向节`和`符号表`  

**可执行文件(ELF格式)组成**: 由`ELF header`,后面跟着`程序头表`或`节头表`，或者两者都有  

### 基本类型
> 以下类型用于 `N 位架构`（N = 32,64，ElfN 代表 Elf32 或 Elf64，uintN_t 代表 uint32_t 或 uint64_t

```c
ElfN_Addr       Unsigned program address, uintN_t
ElfN_Off        Unsigned file offset, uintN_t
ElfN_Section    Unsigned section index, uint16_t
ElfN_Versym     Unsigned version symbol information, uint16_t
Elf_Byte        unsigned char
ElfN_Half       uint16_t  
ElfN_Sword      int32_t
ElfN_Word       uint32_t
ElfN_Sxword     int64_t
ElfN_Xword      uint64_t
```

### ELF header (Ehdr) 
**ELF header**: 由`Elf32_Ehdr`,`Elf64_Ehdr`描述  
```c
#define EI_NIDENT 16

typedef struct {
   unsigned char e_ident[EI_NIDENT];
   uint16_t      e_type;
   uint16_t      e_machine;
   uint32_t      e_version;
   ElfN_Addr     e_entry;
   ElfN_Off      e_phoff;
   ElfN_Off      e_shoff;
   uint32_t      e_flags;
   uint16_t      e_ehsize;
   uint16_t      e_phentsize;
   uint16_t      e_phnum;
   uint16_t      e_shentsize;
   uint16_t      e_shnum;
   uint16_t      e_shstrndx;
} ElfN_Ehdr;

```
**<font color=sky_blue>上述字段的含义如下</font>**:  
`EI_NIDENT`: Elf Identification(ELF标识符) Number of Identification ,即ELF标识符字节数  

`e_ident[]`: 用于识别文件是否为ELF文件以及文件的架构  
   - >**概念**: 描述了一个字节数组，<font color=red>指定了如何解释文件的内容</font>，与处理器或文件的其余部分无关  
   - >**特点**: 所有的东西由<font color=purple>宏命名</font>，以`EI_`为前缀,并且可能包含以`ELF`为前缀的指  
   - >**各个元素**: 参见`man 5 elf`  

`e_type`: <font color=green>表示ELF文件的类型</font>,如可执行文件，共享库等  
`e_machine`: <font color=green>指定ELF文件文件需要的架构</font>  
`e_version`: ELF版本号  
`e_entry`: 当程序被加载到内存并执行时，系统首先转移控制的<font color=green>虚拟地址</font>。（<font color=purple>即程序在内存中开始执行的地址</font>)如果ELF文件没有关联的入口点，那么`e_entry`为0  
`e_phoff`:  存储`Proogram Header Table`在文件中的偏移量(以字节为单位).如果没有，值为0  
   - > **程序头表**: 包含描述程序加载和运行时的信息

`e_shoff`: <font color=red>存储<u>Section Header Table</u>在文件中的偏移量</font>(字节为单位)  
`e_flags`: 存储与文件关联的处理器特定标志  
`e_ehsize`: 存储`ELF header`的大小  
`e_phentsize`: 存储文件的`程序头表`中每个条目的大小.<font color=purple>程序头表中，所有条目的大小相同</font>   
`e_phnum`: 存储`程序头表`中的<font color=green>条目数</font>  
   - >`PN_XNUM`: `e_phnum`可以拥有的最大值   

`e_shentsize`: 存储节头表中每个条目的大小  
`e_shnum`:存储`节头表`中而条目数  
`e_shstrndx`: 存储了节头表中<font color=red>节头部字符串表的索引</font>   
   - 如果字符串表的索引大于等于`SHN_LORESERVE`,则节头表的初始条目`sh_link`存储字符串表的实际索引  

### Program header (Phdr)
> 程序头表中的每个条目描述了一个段，通过解析这些条目，可以了解 ELF 文件在程序执行时需要的各个段的信息，如代码段、数据段等。  

**形式**:可执行文件或共享库的`程序头文件`<font color=red>是一系列结构体</font>,即如下的一个结构体，表示程序头表中的一个条目  
**内容**: 存储了关于程序执行时所需要的段(segment)的信息
```c
typedef struct {
    Elf64_Word  p_type;    // 段类型
    Elf64_Word  p_flags;   // 段标志
    Elf64_Off   p_offset;  // 段在文件中的偏移量
    Elf64_Addr  p_vaddr;   // 段在内存中的虚拟地址
    Elf64_Addr  p_paddr;   // 保留，通常为0
    Elf64_Xword p_filesz;  // 段在文件中的大小
    Elf64_Xword p_memsz;   // 段在内存中的大小
    Elf64_Xword p_align;   // 段的对齐方式
} Elf64_Phdr;

```
- `p_type`：段类型，描述了段的作用和属性，比如可执行、可读、可写等。
- `p_flags`：段标志，更详细地描述了段的属性，如可执行、可读、可写等。
- `p_offset`：段在文件中的偏移量，指示段在 ELF 文件中的起始位置。
- `p_vaddr`：段在内存中的虚拟地址，指示段在程序执行时在内存中加载的位置。
- `p_paddr`：保留字段，通常为零。
- `p_filesz`：段在文件中的大小，指示段的实际大小。
- `p_memsz`：段在内存中的大小，指示段在程序执行时在内存中占用的大小。
- `p_align`：段的对齐方式，指示段在文件和内存中的对齐方式。


### Section header (shdr)
```c
/* 描述了节头表中的 一个条目*/
typedef struct {
    Elf64_Word  sh_name;       // 节名称在节名称字符串表中的偏移量
    Elf64_Word  sh_type;       // 节类型
    Elf64_Xword sh_flags;      // 节标志
    Elf64_Addr  sh_addr;       // 节在内存中的虚拟地址
    Elf64_Off   sh_offset;     // 节在文件中的偏移量
    Elf64_Xword sh_size;       // 节的大小
    Elf64_Word  sh_link;       // 额外信息，依赖于节的类型
    Elf64_Word  sh_info;       // 额外信息，依赖于节的类型
    Elf64_Xword sh_addralign;  // 节的对齐方式
    Elf64_Xword sh_entsize;    // 节中每个条目的大小（仅对包含多个固定大小条目的节有效）
} Elf64_Shdr;
```

- `sh_name`：节名称在节名称字符串表中的偏移量，用于标识<font color=purple>节的名称</font>。
- `sh_type`：节类型，描述了节所包含的数据的类型和用途，如代码、数据、符号表等。
- `sh_flags`：节标志，描述了节的属性，如可执行、可读、可写等。
- `sh_addr`：<font color=green>节在内存中的虚拟地址</font>，指示节在程序执行时在内存中加载的位置。
- `sh_offset`：节在文件中的偏移量，指示节在 ELF 文件中的起始位置。
- `sh_size`：节的大小，指示节所包含的数据的实际大小。
- `sh_link` 和 `sh_info`：额外的节信息，其含义依赖于节的类型。
- `sh_addralign`：节的对齐方式，指示节在文件和内存中的对齐方式。
- `sh_entsize`：节中每个条目的大小，仅对包含多个固定大小条目的节有效。


###  常见的节
1. **文本节（.text）**：文本节通常包含程序的可执行机器指令。它包含程序运行时实际执行的代码。

2. **数据节（.data）**：数据节包含程序在执行过程中使用的初始化数据。它包括具有预定义初始值的全局和静态变量。

3. **BSS 节（.bss）**：BSS（由符号开头的块）节包含未初始化的数据。它通常用于初始化为零或没有显式初始化值的变量。BSS 节的大小在运行时确定。

4. **只读数据节（.rodata）**：只读数据节包含在程序执行期间无法修改的常量数据。它通常包括程序使用的字符串字面值和其他常量。

5. **动态节（.dynamic）**：动态节包含动态链接器/加载器在程序执行期间使用的信息。它包括动态链接信息，如共享库依赖项和重定位信息。

6. **符号表节（.symtab）**：符号表节包含程序中定义和使用的符号的信息。符号可以包括函数、变量和其他程序实体。此信息在链接和调试过程中使用。

7. **字符串表节（.strtab）**：字符串表节包含整个 ELF 文件中使用的以空字符结尾的字符串，例如符号名称、节名称和其他字符串数据。
   - **功能**: <font color=red>用于表示符号和节名</font>  

8. **重定位节（.rel）**：重定位节包含链接器在运行时修改代码和数据节中地址的重定位信息。这对于解析对其他目标文件或共享库中定义的符号的引用是必要的。

9. **PLT（过程链接表）节**：PLT 节包含动态链接的函数调用的存根。它通过将函数调用重定向到适当的动态链接器例程来促进动态链接。

10. **GOT（全局偏移表）节**：GOT 节包含全局变量和函数的地址。它被动态链接器用于解析对全局变量和函数的引用。

### 字符串表节(strtab)
**内容**: 包含以空字符结尾的字符序列  
**特点**: 字符串表的第一个和最后一个字节也被定义为`'\0'`  

### 符号表
符号表中`每个条目`，`描述了一个符号`,<font color=purple>符号表的索引作为对这些符号的引用</font>  
```c
typedef struct {
   uint32_t      st_name;
   unsigned char st_info;
   unsigned char st_other;
   uint16_t      st_shndx;
   Elf64_Addr    st_value;
   uint64_t      st_size;
} Elf64_Sym;
```
**功能**: 用于描述 64 位 ELF 文件中的符号表中的每个符号。符号表中的每个条目都包含了符号的名称、值、大小和其他信息，这些信息对于链接器在链接时解析和处理符号引用非常重要。

- `st_name`：<font color=red>符号的名称在字符串表中的偏移量</font>。通过该偏移量可以找到符号的名称。  

- `st_value`：符号的值，即符号的地址或偏移量。对于不同类型的符号，它可能表示符号的地址或在节中的偏移量。  

- `st_size`：符号的大小，表示符号所占据的字节数。对于函数，它通常表示函数的代码大小；对于变量，它表示变量的大小。

- `st_info`：包含符号的类型和绑定信息。低 4 位表示符号的类型，高 4 位表示符号的绑定信息。符号类型和绑定信息可以使用宏进行解析。(具体看手册)  
   - `ELF64_ST_TYPE(type)`: 

- `st_other`：保留字段，一般情况下不使用。

- `st_shndx`：符号所属的节的索引。它指示了符号定义或引用所在的节。这个索引可以用来确定符号在哪个节中定义或引用。

`Elf32_Sym` 结构体的定义

#### ST_INFO
```c
/* Legal values for ST_BIND subfield of st_info (symbol binding).  */

#define STB_LOCAL	0		/* Local symbol */
#define STB_GLOBAL	1		/* Global symbol */
#define STB_WEAK	2		/* Weak symbol */
#define	STB_NUM		3		/* Number of defined types.  */
#define STB_LOOS	10		/* Start of OS-specific */
#define STB_GNU_UNIQUE	10		/* Unique symbol.  */
#define STB_HIOS	12		/* End of OS-specific */
#define STB_LOPROC	13		/* Start of processor-specific */
#define STB_HIPROC	15		/* End of processor-specific */

/* Legal values for ST_TYPE subfield of st_info (symbol type).  */

#define STT_NOTYPE	0		/* Symbol type is unspecified */
#define STT_OBJECT	1		/* Symbol is a data object */
#define STT_FUNC	2		/* Symbol is a code object */
#define STT_SECTION	3		/* Symbol associated with a section */
#define STT_FILE	4		/* Symbol's name is file name */
#define STT_COMMON	5		/* Symbol is a common data object */
#define STT_TLS		6		/* Symbol is thread-local data object*/
#define	STT_NUM		7		/* Number of defined types.  */
#define STT_LOOS	10		/* Start of OS-specific */
#define STT_GNU_IFUNC	10		/* Symbol is indirect code object */
#define STT_HIOS	12		/* End of OS-specific */
#define STT_LOPROC	13		/* Start of processor-specific */
#define STT_HIPROC	15		/* End of processor-specific */
```

### 重定向条目(Rel & Rela)暂时不看



