# 部分参数,变量的含义
**<font color=purple>is_batch_mode</font>**:[^1]  
> 含义: 批处理模式  

> 值1: **true**-进入批处理模式，运行nemu后，直接运行整段程序(即执行cmd_c)  

> 值2: **false**-不进入批处理模式，运行nemu后，等待指令的输入  

**<font color=purple>gpr[32]</font>**:[^2]  
> 含义: RISCV64架构计算机系统的寄存器  

---
# nemu代码解析
- **<font color=purple>简介</font>**: 一款经过简化的计算机系统模拟器,被称为`客户计算机`  
- **<font color=purple>运行命令</font>**: make run  
- **<font color=purple>生成的可执行文件</font>**:/home/awjl/workspace/ysyx/ysyx-workbench/nemu/build/riscv64-nemu-interpreter  
### init_monitor() : 执行一些全局初始化操作
- <font color=blue> parse_args():</font>   
   - `功能`: 用于对执行nemu时命令的参数分析
   - `使用1`: ./riscv64-nemu-interpreter -b  
      - > 效果: 进入批处理模式  
   - `使用2`:可以在\$NEMU_HOME/scripts/native.mk中在变量NEMU_EXEC的后面添加选项(如-b -p -l -d)  

- <font color=blue>init_rand()</font>:   
   - `功能`: 初始化伪随机数生成器  
   - `原理`: 如果宏`CONFIG_TARGET_AM`值为假(<font color=brown>默认为假</font>)，则srand参数为time(0)  
   - `原理`: 如果值为真，则srand参数为0,则每次产生相同的随机数序列  

- <font color=blue>init_log()</font>:   
   - `功能`: 将log写入指定的log_file中  
   - `使用`: 在运行时，加入参数`--log=log_file`给定log文件及其路径  

- <font color=blue>init_mem()</font>:   
   - `功能`(guess): 给pmem生成一个随机的地址  


- <font color=blue>init_isa()</font>:   
   - `功能`: 将`内置的客户程序`加载到内存中,初始化pc,0号寄存器  

- <font color=blue>load_img()</font>:   
   - `功能`: 加载客户程序到内存中(会覆盖内置客户程序)  
      - > img: nemu中运行的程序称为`客户程序`  
   - `使用`: 运行NEMU时通过添加参数来指定  

- <font color=blue>init_difftest()</font>:   
   - `功能`: 默认没定义宏`CONFIG_DIFFTEST`,因此不执行  

- <font color=blue>init_sdb()</font>:   
   - `功能`: 编译正则表达式,方便之后使用;初始化监视点池  

- <font color=red>init_disasm()</font>:   
   - `功能`: 初始化反汇编器  
   - `原理`: <font color=red>暂时没去阅读</font>  

### cpu_exec() - 模拟CPU的工作
- <font color=blue>nemu的集中运行状态</font>:   
   - `NEMU_RUNNING`  
   - `NEMU_STOP`  
   - `NEMU_END`  
   - `NEMU_ABORT`: 终止程序运行  
   - `NEMU_QUIT`  

- execute(-1):
   - `作用`: 执行$2^64-1$次指令，相当于执行完内存中的所有指令  
---

# isa模拟过程
1. **初始化了pc和gpr[0]**:
   - 执行: `nemu_main()`调用`init_isa()`:
2. 调用`execute(-1)`来执行所有指令  
3. 初始化Decode结构体,并开始循环执行`exec_once(&s,cpu.pc)`  
   - ><font color=green>s->pc   = pc;</font>   
   - ><font color=green>s->snpc = pc;</font>   

4. 调用`isa_exec_once`:  
   - > <font color=green>s->snpc+=4</font>   
   - `取指inst_fetch()`: 传入`虚拟地址pc`,通过`guest_to_host()`，<font color=red>将虚拟地址转换为物理地址来</font>`访问存储器pmem`  
```c
uint8_t* guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; } 
```
5. **译码**:`decode_exec(Decode *s)`  
   - > <font color=green>dnpc=snpc</font>   
      - > 根据不同跳转指令，dnpc可能会取其他值  
6. 译码后，执行相应操作。  
7. 令`R(0) = 0`  
8. `cpu.pc = s->dnpc`  

## 用到的结构体
**Decode结构体**:  
```c
typedef struct Decode {
  vaddr_t pc;
  vaddr_t snpc; // static next pc
  vaddr_t dnpc; // dynamic next pc
  ISADecodeInfo isa;
  IFDEF(CONFIG_ITRACE, char logbuf[128]);
} Decode;
```
**定义了cpu结构体**:包含了当前pc和通用寄存器  
```c
typedef struct {
  word_t gpr[32];
  vaddr_t pc;
} riscv64_CPU_state;
```
---

# nemu为调试添加的工具
## itrace - 指令执行的踪迹
**位置**:`nemu/src/cpu/cpu-exec.c`中  

# nemu代码中所使用到的宏

## 1. 对调试有用的宏
定义于`nemu/include/debug.h`  

### Log()
**简介**:`Log()`是`printf()`的升级版,专门<font color=red>用来输出调试信息</font>,同时还会输出使用`Log()`所在的源文件,行号和函数。  
**用处**:这使得当输出的调试信息过多时，可以方便地定位到代码中的相关位置  
**使用格式**: `Log(format,...)`

> tip: <font color=purple>Log输出时的字体颜色还可以设置</font>, 根据源文件debug.h，nemu<font color=blue>默认设置log输出的颜色为`蓝色`</font>  
- > **颜色选择**: \$NEMU_HOME/include/utils.h 中有定义  

**代码解读**:   
   - <font color=brown>宏展开</font>: `_Log(ANSI_FG_BLUE "[%s:%d %s] " format ANSI_NONE "\n", __FILE__, __LINE__, __func__, ## __VA_ARGS__)`  
   - <font color=brown>参数</font>: `format`是一个字符串,如`" 请输入一个数字:%d"`  
      - `## __VA_ARGS__` 一般用来作为format字符串里`%d`(或`%f`等等)对应的变量。类似于`printf()`  



### Assert()
`Assert()`是`assert()`的升级版:当<font color=purple>测试条件为假</font>时,在assertion fail之前可以输出一些信息  
格式: `Assert(cond, format, ...)`

### panic()
`panic()`用于输出信息并<font color=red>结束程序</font>,相当于<font size=5>`无条件`</font>的`assertion fail`  

## macro.h中的宏
### IFDEF(macro, ...)
- 展开1: `MUXDEF(CONFIG_DEVICE, __KEEP, __IGNORE)(init_device())`
- 展开2: `MUX_MACRO_PROPERTY(__P_DEF_, CONFIG_DEVICE, __KEEP, __IGNORE)(init_device())`  
- 展开3: `MUX_WITH_COMMA(__P_DEF_ ## CONFIG_DEVICE, __KEEP, __IGNORE)(init_device())`  
- 展开4: `CHOOSE2nd(__P_DEF_ ## macro __KEEP, __IGNORE)(init_device())`  
- 展开5-1: 若macro未被定义,则`__P_DEF_ ## macro`会被定义为空字符串
   - 即`CHOOSE2nd(__KEEP,__IGNORE)(init_device())` = `空`  
- 展开5-2: 若macro被定义,则`__P_DEF_ ## macro`会被定义为`X, ` 
   - 即`CHOOSE2nd(X,__KEEP,__IGNORE)(init_device())` = `init_device()`  

---

# 程序失败会输出的信息即过程
**失败原因**:一般失败是由于`Assert(cond)`导致,即条件cond不满足时  

**输出信息**: Assert会调用函数`assert_fail_msg()`,位于`nemu/src/cpu/cpu-exec.c`  
   - `isa_reg_display()`: 打印所有寄存器的值  
   - `statistic()`:输出运行花费时间，总共执行的指令数  


# nemu从.bin文件中得到指令的过程
```c
static uint8_t pmem[0x80000000] = {};

static long load_img () {

    static char *img_file = "1.bin";
    if (img_file == NULL) {
        printf ("No image is given. Use the default build-in image.");

    FILE *fp = fopen (img_file, "rb");

    fseek (fp, 0, SEEK_END);
    long size = ftell (fp);

    printf ("The image is %s, size = %ld\n", img_file, size);
    fseek (fp, 0, SEEK_SET);
    int ret = fread (pmem, size, 1, fp);    // 将image的内容存入地址中

    fclose (fp);
    return size;
}


int main () {
    int size = load_img();
    for (int i = 0; i < size; ) {
        printf("0x%08x\n",*(uint32_t*)(pmem+i));
        i+=4;
    }
    return 0;
}
```
1. 给定`img_file`的文件路径  
2. 打开指定文件，并读取所有内容到pmem中  
3. 即获得了所有指令

# 相关概念
NEMU是一个用来执行其他程序的程序，叫**通用程序**  
   - 通俗含义: 其他程序能做的事，它也能做  


# 注脚注释
[^1]: nemu/scs/monitor/sdb/sdb.c
[^2]: \$nemu/src/isa/riscv64/include/isa-def.h

