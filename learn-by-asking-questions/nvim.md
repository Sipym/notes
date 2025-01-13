# learn nvim by asking questions

## 在我的nvim配置文件用到的那些lua语言的实际含义是什么？
**require函数的用法**:  
```lua
-- require用于加载一个模块
require("<模块名>")

-- require也可以这么用
require("<模块名>").function();

-- 还能这样
local m = require("module")
print(m.constant)
m.func3()

```

## nvim和vim的命令区别，也就是nvim如何用lua配置好环境
