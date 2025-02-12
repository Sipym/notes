# info 命令输出信息
## 断点
```
Num     Type    Disp    Enb     Address         what
```
Num: 断点编号  

Type: breakpoint

Disp: 是临时断点还是永久断点(keep)  

Enb: 是启用还是禁用状态，y表示启用  

Address: 断点所在的位置  

what: 断点当前的状态(作用的行号，已经命中的次数等)  

## 监视点

```
Num     Type    Disp    Enb     Address         what
```
Num: 监视点编号  

Type: hw watchpoints

Disp: 是临时还是永久(keep)  

Enb: 是启用还是禁用状态，y表示启用  

Address: **不显示**  

what: **显示被观察的表达式**  
