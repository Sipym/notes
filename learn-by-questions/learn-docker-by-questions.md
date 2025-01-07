# learn docker by questions

## question1: docker architecture 是什么样的? 
已解决,详细见`~/notes/工具/docker/docker-architecture.md`。


## question2: 容器是如何运行以及管理的？
1. 可以通过`docker run`或`docker container create`来创建一个容器，并运行  
2. 当容器停止时，可以再次启动，或者移除。  


## question3: :star:如何通过dockerfile创建一个自己的镜像？
1. **base image**: 所有镜像都是基于`base image`延伸而来的。它<font color = red>指的是 Dockerfile 中 FROM 指令的内容</font>  
   - > 不需要自己创建，包含一个庞大的 Docker 镜像库，适合在构建过程中用作基础镜像  
   - > Docker官方、已验证发布者以及赞助的开源软件镜像 都有相应的标志  
   ```Dockerfile
   FROM debian
   ```

2. ...


## question4: 如何创建一个自己的开发环境？
1. 直接使用 `base image`,如`docker run -it --name my_ubuntu_container ubuntu:24.04 /bin/bash`,然后便启动了容器  

2. 在容器中，进行我的开发环境的配置.  

3. 退出容器. `exit`

4. 将修改后的容器保存为新镜像。 `docker commit my_ubuntu_container my_custom_ubuntu:v1`  

5. 验证新镜像。 `docker images`  

6. 创建docker hub仓库,如`awjl/env-dev`  

7. 给镜像打标签，<font color = red>使镜像符合Docker hub命名规则</font>。  
   - `docker tag [image id] yourusername/myapp:v1.0`  

8. 上传镜像到Docker Hub. `docker push yourusername/myapp:v1.0`  

9. 可以验证是否上传成功，看看docker hub,或者试试能不能拉取。  
