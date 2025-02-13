# 基本介绍
## gRPC (Google Remote Procedure Call)
**概述**: 是一款语言中立、平台中立、开源的远程过程调用(RPC)系统.  

**思想**: 定义一个服务， 指定其可以被远程调用的方法及其参数和返回类型。默认使用`Protocol buffers`作为接口定义语言，来描述服务接口和有效载荷信息结构`。  

**特点**: gRPC使用`Protocol Buffers`作为它的<font color = purple>接口定义语言</font>(IDL)和它的<font color = purple>底层信息交互格式</font>.  

**特点**: 客户端应用程序可以像调用本地对象一样直接调用不同机器上服务器应用程序，这样就能更轻松地创建分布式应用程序和服务  

**特点**: gRPC 客户端和服务器可以在各种环境中运行并相互对话, 而且可以用任何一种 gRPC 支持的语言编写  

## Protocal Buffers
**概述**: 是一种语言中立、平台中立的结构化数据序列化可扩展机制

**功能**: 只需定义一次数据的结构化方式，然后就可以使用专门生成的源代码，<font color = red>使用各种语言</font>轻松地<font color = blue>:one:将结构化数据写入各种数据流</font>或<font color = blue>:two:从各种数据流中读出结构化数据</font>。

**Protocal Buffers工作原理如下**：  
首先， 在 proto 文件中定义要序列化的数据结构。Protocal Buffers的数据结构为message，其中每条message都是一条小的逻辑信息记录，包含一系列称为字段的名-值对。下面是一个简单的例子:  
```protobuf
message Person {
  string name = 1;
  int32 id = 2;
  bool has_ponycopter = 3;
}
```

然后，一旦指定了数据结构，就可以使用protoc从proto定义中以首选语言(如Cpp)生成数据访问类, 这些类为每个字段提供简单的访问器，如`set_name(),name()`等,以及序列化/反序列化的方法  

## 其他概念
**序列化**: 将结构化数据转换为可以存储或传输的形式(如字节流)  
**反序列化**: 将字节流还原成结构化数据的过程  


## gRPC项目的实现步骤
1. 通过`Protocal Buffers`定义服务(RPC接口)和消息结构(请求和响应格式).   
2. 通过编译器protoc生成服务器端和客户端的接口代码。  
3. 实现服务器端: 

# gRPC核心概念、架构和生命周期

