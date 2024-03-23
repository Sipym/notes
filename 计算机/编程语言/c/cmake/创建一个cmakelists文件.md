# 各个选项的介绍
    1. cmake_minimum_required: 指定运行此配置文件所需的 CMake 的最低版本；
    2. project：参数值是 Demo1，该命令表示项目的名称是 Demo1 。
    3. add_executable： 将名为 main.c 的源文件编译成一个名称为 Demo 的可执行文件。
    4. add_executable(Demo ${DIR_SRCS}):会将当前目录下所有源文件赋值给 DIR_SRCS 变量
    5. add_subdirectory :指明本项目包含一个子目录 math
    6. target_link_libraries 指明可执行文件 main 需要连接一个名为 MathFunctions 的链接库 
# 针对单个源文件
``` cmake
# CMake 最低版本号要求
cmake_minimum_required (VERSION 2.8)

# 项目信息
project (Demo1)

# 指定生成目标
add_executable(Demo main.c)
```

# 同一目录下，多个源文件
    工作目录
    ./Demo2
    |
    +--- main.cc
    |
    +--- MathFunctions.cc
    |
    +--- MathFunctions.h

``` cmake
# CMake 最低版本号要求
cmake_minimum_required (VERSION 2.8)

# 项目信息
project (Demo2)

# 查找当前目录下的所有源文件
# 会将当前目录下所有源文件赋值给 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 指定生成目标Demo的名字可自定义
add_executable(Demo ${DIR_SRCS})
```

# 多个目录多个源文件
    需要在每个子目录下创建一个cmakelist文件
    目录结构
    ./Demo3
    |
    +--- main.cc
    |
    +--- math/
          |
          +--- MathFunctions.cc
          |
          +--- MathFunctions.h
    +--- hello/
          |
          +--- hello.h
          |
          +--- hello.c
``` cmake
#主目录下的cmakelist
# cmake 最低版本号要求
cmake_minimum_required (VERSION 2.8)

# 项目信息
project (Demo3)

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 添加 math,hello 子目录
add_subdirectory(math)
add_subdirectory(hello)

# 指定生成目标 
add_executable(Demo main.cc)

# 添加链接库
target_link_libraries(Demo MathFunctions)
target_link_libraries(Demo hello)
```

``` cmake
#子目录下的cmakelists
# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_LIB_SRCS 变量
aux_source_directory(. DIR_LIB_SRCS)

# 生成链接库
add_library (MathFunctions ${DIR_LIB_SRCS})

```



