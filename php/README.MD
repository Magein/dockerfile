### 文件说明
    
    composer.yml 以集群方式启动nginx+php的文件
    
    Dockerfile.MD  包含注释的文件
     
    nginx.conf nginx的配置文件
     
### 安装扩展

    1. 在dockerfile中根据需求，使用pecl pear加载对应的扩展。推荐使用，可能有些扩展需要一些开发包的支持。如果使用下面一种方式，需要映射很多文件
     
    2. 在宿主机中使用的开发包+pecl安装，参见php-devel+pear.MD。这种不推荐使用，只供参考。并不局限与php容器扩展，通过rpm，yum安装的php，扩展也可以使用这种方式