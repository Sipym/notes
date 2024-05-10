# C解析可执行文件(ELF格式)实例
**<font color=blue>首先打开xxx.elf文件</font>**:  
```c
FILE *file = fopen("xxx .elf","rb");
```
## Elf header table
```c
Elf64_Ehdr elf_header; 
fread(&elf_header,sizeof(Elf64_Ehdr),1,file);
```

## Section header table
```c
Elf64_Shdr *section_header = malloc(sizeof(Elf64_Shdr) * elf_header.e_shnum);

fseek(file,elf_header.e_shoff,SEEK_SET);
fread(section_header,sizeof(Elf64_Shdr),elf_header.e_shnum,file); // 得到节头表地址
```
**使用**: **<font color=red>section_header[index]</font>**  
> 因此需要得到要用的节的索引  

### 节头字符串节表shstrtab
```c
Elf64_Shdr shstrtab = section_header[elf_header.e_shstrndx];
```
**原理**: 节头字符串表的索引在`elf_header`中已经给出  

### 寻找指定节(如strtab,symtab)  
```c
    Elf64_Shdr shstrtab = section_header[elf_header.e_shstrndx];
    Elf64_Shdr strtab;
    Elf64_Shdr section_symtab;

    /* 从节头字符串节中得到字符串节.strtab*/
    for (int j = 0; j < elf_header.e_shnum; j++) {
        fseek (file, shstrtab.sh_offset + section_header[j].sh_name, SEEK_SET);
        int  i = 0;
        char ch;
        while ((ch = fgetc (file)) != EOF && ch != '\0') { str[i++] = ch; }
        str[i] = '\0';
        // 找到了strtab节
        if (strcmp(str,".strtab") == 0) {
            printf ("%s + hhh\n", str);
            strtab = section_header[j]; //得到strtab节
        }
        // 找到了symtab节
        if (strcmp(str,".symtab") == 0) {
            printf ("%s + hhh\n", str);
            section_symtab = section_header[j]; //得到strtab节
        }
    } 

```
> 如上: 得到了 **<font color=red>字符串表</font>** 和 **<font color=red>符号表</font>**  

**原理**: 找到shstrtab后，就可以得到`section_header[index].sh_name`在shstrtab对应的名称,通过一些比较即可得到指定的节  

## Symbol table
```c
    Elf64_Shdr shstrtab = section_header[elf_header.e_shstrndx];
    Elf64_Shdr strtab;
    Elf64_Shdr section_symtab;

    /* 从节头字符串节中得到字符串节.strtab*/
    for (int j = 0; j < elf_header.e_shnum; j++) {
        fseek (file, shstrtab.sh_offset + section_header[j].sh_name, SEEK_SET);
        int  i = 0;
        char ch;
        while ((ch = fgetc (file)) != EOF && ch != '\0') { str[i++] = ch; }
        str[i] = '\0';
        // 找到了strtab节
        if (strcmp(str,".strtab") == 0) {
            printf ("%s + hhh\n", str);
            strtab = section_header[j]; //得到strtab节
        }
        // 找到了symtab节
        if (strcmp(str,".symtab") == 0) {
            printf ("%s + hhh\n", str);
            section_symtab = section_header[j]; //得到strtab节
        }
    } 
    int symtab_num = section_symtab.sh_size;
    Elf64_Sym *symtab = malloc(symtab_num);
    fseek(file,section_symtab.sh_offset,SEEK_SET);
    fread(symtab,sizeof(Elf64_Sym),symtab_num/sizeof(Elf64_Sym),file);

```
**原理**: 先找到了节头表中的成员`.symtab`. 然后利用这个得到`Symbol Table`  
**使用**: symtab[index], <font color=red>index为对应符号表项的项数</font>  
