# 操作
部分可见~/.tmux.conf文件中  

## 重命名
窗口重命名: `ctrl + a ,`  
会话重命名: `ctrl + a $`  

## 关闭会话
`tmux kill-session -t 0` : 使用会话编号杀死某个会话  
`tmux kill-session -t <session name>`: 使用会话名称杀死某个会话  

`tmux kill-server`: 关闭所有会话  

## 创建新会话
`ctrl+a' + 'c'  
