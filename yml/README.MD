### 启动顺序

    集群方式启动nginx+php应该先启动php，nginx.conf中需要使用到容器的名称
     
    nginx.conf是映射到docker容器中，所以配置文件中的路径需要指向容器中的路径，宿主机的文件映射到docker容器中，会自动在容器中生成对应的文件
     
    附：
     
    主机中的文件挂载到文件，主机中的文件一定要存在，docker容器中的文件存在会被覆盖，不存在则会创建
      
    主机中的文件夹和文件要与容器中的一致，不能文件夹挂载到文件，文件挂载到文件夹
     
    挂载的时候，挂载的如果是目录尽量在路径后面加上/ 