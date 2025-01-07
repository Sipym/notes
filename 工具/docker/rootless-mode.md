# rootless模式(并不影响正常使用)

**启动daemon**: `systemctl --user start docker`  



**Remarks about directory paths**:  

systemd unit file: `~/.config/systemd/user/docker.service`  

The socket path is set to `$XDG_RUNTIME_DIR/docker.sock` by default. `$XDG_RUNTIME_DIR` is typically set to `/run/user/$UID`.    

The data dir is set to `~/.local/share/docker` by default. The data dir should not be on NFS.    

The daemon config dir is set to `~/.config/docker` by default. This directory is different from `~/.docker` that is used by the client.  


## 与普通模式的区别(具体看文档)
1. 权限和安全性：
   - 普通模式：Docker守护进程以root权限运行，这可能带来潜在的安全风险。
   - Rootless模式：Docker守护进程和容器以非root用户身份运行，大大降低了安全风险。

   [Docker Engine security](https://docs.docker.com/engine/security/#docker-daemon-attack-surface)文档指出，普通模式下的Docker守护进程可能成为攻击面，而rootless模式可以缓解这个问题。

2. 功能限制：
   - 普通模式：几乎可以使用所有Docker功能。
   - Rootless模式：有一些功能限制，如[Docker Engine Rootless mode](https://docs.docker.com/engine/security/rootless/#known-limitations)文档中提到的：
     - 不支持AppArmor
     - 不支持Checkpoint
     - 不支持Overlay网络
     - 不支持暴露SCTP端口

3. 存储驱动：
   - 普通模式：支持多种存储驱动。
   - Rootless模式：只支持有限的几种存储驱动，主要是overlay2、fuse-overlayfs和vfs。

4. 网络：
   - 普通模式：容器IP可以从主机直接访问。
   - Rootless模式：容器IP被命名空间隔离，不能从主机直接访问，需要使用nsenter或端口映射。

5. 端口绑定：
   - 普通模式：可以绑定任何端口。
   - Rootless模式：<font color = red>默认只能绑定1024以上的端口</font>，需要额外配置才能绑定特权端口。

6. 性能：
   - 普通模式：通常性能较好。
   - Rootless模式：由于额外的用户命名空间映射，可能会有轻微的性能开销。

7. 安装和配置：
   - 普通模式：安装较为简单。
   - Rootless模式：需要一些额外的设置步骤，如[Docker Engine Rootless mode](https://docs.docker.com/engine/security/rootless/#prerequisites)文档中所述。

8. 资源限制：
   - 普通模式：可以使用全部的cgroup功能。
   - Rootless模式：某些cgroup相关的资源限制功能可能不可用或需要额外配置。

总的来说，rootless模式提供了更好的安全性，但代价是功能和灵活性有所限制。对于需要增强安全性的环境，特别是多用户系统或不信任的环境，rootless模式是一个很好的选择。但对于需要完整Docker功能的场景，可能还是需要使用普通模式。
