1. 命令： verilator -cc --exe --build -j top.v sim_main.cpp
2. 若工程中还包含了其他.v,.cpp文件添加进去即可
3. 当工程中由多个.v文件时，应该在命令中加入--top-module top_name 来指定顶层.v文件  
> 如 --top-module top
