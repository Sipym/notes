# [how to use `docker run` to run containers](https://docs.docker.com/engine/containers/run/)

> :bulb: **容器概述**: Docker 在隔离的容器中运行进程。容器是在主机上运行的进程。主机可以是本地的，也可以是远程的  

## 一般形式
```bash
docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
```

> docker run必须指明一个image references以创建一个容器  

---
### image references
**image references**: 镜像的名字和版本。  

- `TAG`: 镜像的版本，省略时默认是`latest`  

- `DIGEST`: 镜像摘要是镜像内容的SHA256哈希值,<font color = red>可以唯一且不可变地标识一个特定版本的镜像</font>  

---

### Options
**用途**: [OPTIONS]可以让你配置容器的选项。
- > `--name`: 你可以给容器命名（--name）

- > `-d`: 或将其作为后台进程运行（-d）。  

- > `--cpus="number"  --memory="4g"`: 可以设置选项来控制资源限制和联网等事项.    

- > `-v ~/workspace:/workspace image-name`: <font color = darkred>使用卷volumes挂载我的工作目录或者配置文件目录，用于主机和容器之间共享文件</font>。  

---

### Commands and arguments
> :bulb: <font color = purple>您可以使用 [COMMAND] 和 [ARG...] 位置参数来指定容器启动时要运行的命令和参数</font>  


---

## ...
