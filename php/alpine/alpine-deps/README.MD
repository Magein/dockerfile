### 文件说明

   > 每次重新构建php镜像的时候需要花费大量的时间在安装alpine依赖和php插件所需要依赖上
   
   > 在阿里云容器服务上，安装需要大约25-30分钟，花费在安装依赖大约是15-20分钟
   
   > 所以把alpine的依赖，以及php的依赖全部分离出来，基于alpine系统所需要的依赖可通过命令直接删除 alpine-deps -d
   
### 依赖镜像

   > 依赖单独的 alpine-deps 镜像 ，这里的只是为php单独设计
   
   > alpine-deps的地址
    
   > dockerfile :https://github.com/Magein/dockerfile/tree/master/alpine-deps
   
   > 镜像地址：registry.cn-hangzhou.aliyuncs.com/magein/alpine-deps