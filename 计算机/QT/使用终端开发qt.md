# 使用vim开发qt步骤
[笔记参考链接](https://blog.csdn.net/tennysonsky/article/details/47981259)
1. `qmake -project`:生成.pro工程文件  
   - TEMPLATE: 为建立目标文件而采用何种模板
      > app: 为建立QT应用程序  
      > lib: 为建立应用程序库
   - TARGET: 目标文件的名称
   - INCLUDEPATH: 需要搜索的头文件路径
   - HEADERS: 告诉编译器，`.h文件路径`及其包含文件  
   - SOURCES: 告诉编译器，源文件路径及其包含文件  
   - FORMS: 添加designer生成的.ui文件(<font color=purple>需要到qtcreator上绘画</font>)
   - <font color=red>根据需求添加相应模块</font>: `QT += 模块名`  
2. `qmake`: 生成makefile，用于生成可执行文件  
3. 运行`bear -- make`，生成clang需要的依赖关系  
4. 可以开始写qt了  
