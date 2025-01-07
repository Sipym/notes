# [commands](https://docs.docker.com/reference/cli/docker/)
## template
```bash
# 模板
```

## daemon-related
```bash
# rootless模式: 启动docker 服务,即启动daemon
systemctl --user start docker

# rootless模式: 重新加载配置文件
systemctl --user daemon-reload

# rootless模式: 重新启动docker服务
systemctl --user restart docker

```

## contianer-related
```bash
# 查看容器状态
docker ps -a

# 删除已停止的容器
docker rm <container_id_or_name>

```



