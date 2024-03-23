# 算术运算符
`+`,`-`,`*` , `/`, `%`, `+=`, `-=`, `*=`, `/=`, `%=`  
`**`: 求幂

## bash执行算术运算
**使用双括号**: `$((expresion))`[`$`可要可不要]  
> `$((10+3))`
实例:  
```bash
Num1=10  
Num2=3  
Sum=$((Num1+Num2))  
echo "Sum = $Sum"
```

---
**使用Let构建**: `let <arithmetic expression>`  
```bash
x=10  
y=6  
z=0  
echo "Addition"  
let "z = $(( x + y ))"  
echo "z= $z"  

echo "Substraction"  
let "z = $((x - y ))"  
echo "z= $z" 
```

---
**使用反引号**:...  


