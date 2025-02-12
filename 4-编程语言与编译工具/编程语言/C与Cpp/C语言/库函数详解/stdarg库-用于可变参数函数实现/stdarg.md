# stdarg库
```c
void va_start(va_list ap, last);
type va_arg(va_list ap, type);
void va_end(va_list ap);
void va_copy(va_list dest, va_list src);
```
## va_list
```c
va_list ap;
```
**含义**: 应该是<font color=purple>用于指向参数的指针</font>  
**用处**: 使用上面那些宏时，必须定义它  

## va_start()
**功能**: 为之后使用`va_arg()`,`va_end()`初始化`ap`,并且`va_start()`必须第一个调用  
**last参数**:  是`可变参数列表前`的`最后一个参数`的名字  

## va_arg()
**功能**: 会展开为一个表达式，该表达式具有`调用中下一个参数`的<font color=purple>类型和值</font>  
**行为**: 每次调用`va_arg()`都会修改ap,以便<font color=sky_blue>下次调用返回下一个参数</font>  
**type参数**: 是参数的类型的名称(如果是指针，则包括`*`)  
   - 如果`type`与参数类型不兼容，则会发生`随机错误`  

**注意**:   
   - 如果没有下一个参数或`type`与参数类型不兼容，则会发生`随机错误`  
   - 如果将`ap`传递给一个函数，而这函数内部使用了`va_arg()`，可能会导致`ap`变得会定义  

**<font color=purple>实际应用</font>**: 在`va_start()`后使用，第一次调用`va_arg()`时，将会返回`last参数`后的一个参数  

## va_end()
**意义**: 每一个`va_start()`的调用，必须匹配一个相应的`va_end`  
**作用**: 在`va_list`之后，`ap`将变得未定义  


