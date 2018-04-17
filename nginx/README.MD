### version

    nginx-1.12.2

### 配置说明
    
    1. 在docker中运行nginx的时候，配置中的 root 目录一定要指向容器中的，
     
    2. fastcgi_pass 的参数配置一定要根据启动方式配置，链接在同一网络下可以根据ip，容器名字使容器相互访问 