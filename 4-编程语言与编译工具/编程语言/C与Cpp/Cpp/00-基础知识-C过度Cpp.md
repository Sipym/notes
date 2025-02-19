# C++ 核心基础(与C不太一样的地方)

**wchar_t**`(new data type)`:  2Byte   

---
**:star:constexpr**:  
- > **功能**: 使编译器<font color = red>在编译时计算表达式的值</font>
- > **好处**: 避免了在运行时的重复运算  
- > **tips**: 不能使用 constexpr 变量调用未声明为 constexpr 的函数  
  ```cpp
  // constexpr用法
  
  #include <iostream>
  using namespace std;
  
  // a constexpr function that
  // returns nth fibonacci number
  constexpr int fib(int n) {
  
      // returns n if n <= 1
      // else, recursively calls fib(n - 1) + fib(n - 2)
      return n <= 1 ? n: fib(n - 1) + fib(n - 2);   
  }
  
  int main() {
  
      // two constexpr variables that store
      // the return values of constexpr function
      constexpr int fibonacci_five = fib(5);
      constexpr int fibonacci_ten = fib(10);
  
      cout << "fib(5) : "<< fibonacci_five << endl;
      cout << "fib(10) : "<< fibonacci_ten;
  
      return 0;
  }
  ```


---
**Const Member Function**:  
- > **功能**: 常量成员函数确保对象的数据成员不会被更改  
- > **注意**: `const object`不能调用`non-const member function`   
  ```cpp
  //语法形式
  return_type function_name() const {
      // function body
  }
  ```

---
**C++ cout**:  
- > **功能**：将格式化的输出发送到标准输出设备,如屏幕  
- > **cout with <<**:其中`<<`可以使用多次  
   ```cpp
   // 首选方式
   std::cout << "hhhh" << var_name << endl;
   
   using namespace std;
   cout << "hhhh";  //可以省略std,但是不推荐这么写  
   ```

- > **<font color = skyblue>cout with Member Functions</font>**:  
   - `cout.put(char &ch)`: Displays the character stored by ch.
   - `cout.write(char *str, int n)`: Displays the first n character reading from str.
   - `cout.setf(option)`: Sets a given option. Commonly used options are left, right, scientific, fixed, etc.
   - `cout.unsetf(option)`: Unsets a given option.
   - `cout.precision(int n)`: Sets the decimal precision to n while displaying floating-point values. Same as cout << setprecision(n).


---

**C++ cin**:  
- > **功能**: 从标准输入设备中获取格式化的输入  
- > **cin with >>**: `>>`能够使用多次 
- > **<font color = skyblue>cin with member functions</font>**: ...


---

**:star:Ranged Based for loop**: <font color = purple>new in C++11</font>  
- > **目的**： <font color = red>用于处理arrays和vectors等</font>   
- > **用法**: 对于`collection`中的每一个值都会赋给`variable`并执行一次循环  
   ```cpp
   for (variable : collection) {
       // body of loop
   }
   ```


---


**Function Default Argument**: 可通过函数声明中指定参数的默认值，从而在调用函数时(缺失参数传递)使用默认值  
   - > **tips**: 一旦为某个参数指定了默认值，该参数后的所有参数都需要指定默认值  
   ```cpp
   void temp(int = 10, float = 8.8);
   int main() {
      temp(); //等效于temp(10,8.8)
   }
   void temp(int i, float f) {
      //code
   }
   ```

---

**:star:<font color = red>Function Overloading</font>**:  
- > **功能**: C++中，两个函数可以有相同的名字，<font color = red>只要传递的参数的数量或类型不同</font>  
   ```cpp
   // same name different arguments
   int test() { }
   int test(int a) { }
   float test(double a) { }
   int test(int a, double b) { }
   ```

---

**Inline Functions**:  
- > **功能**: 在编译的时候，复制函数到调用函数的位置。  
- > **好处**: 可能会使得程序执行的更快  
   ```cpp
   inline returnType functionName(parameters) {
       // code
   }
   ```

---

**C++ strings**: 有两种定义形式  
- > **C-strings**: 和C一样的定义方式  
- > **string objects**:  
   ```cpp
   std::string str = "hello";
   // 使用R,可以不需要转义字符\来表示特殊字符
   std::string str = R"hello
   World"; //equal "hello\nWorld"
   ```

---





