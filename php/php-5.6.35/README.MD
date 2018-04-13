### 版本
    
    CentOS Linux release 7.4.1708
     
    kernel 3.10.0-693.11.1.el7.x86_64
     
    Docker version 17.06.1-ce, build 874a737
     
    php-5.6-35
     
    nginx-1.12.2
     
    docker 17.x以后要求kernel内核在3.10以上
     
    由于docker是跨平台的，所以原则上对操作系统不做限制
     
    nginx+php 其实不限制nginx版本，这里表明，只是我自己使用的信息
    
### 文件说明
    
    composer.yml 以集群方式启动nginx+php的文件
     
    Dockerfile docker编译php的镜像文件
     
    Dockerfile.md  包含注释的文件
     
    nginx.conf nginx的配置文件
     
    php.ini php的配置文件
     
    php-fpm.conf php-fpm管理器的配置文件
     
    php-fpm.conf.default php-fpm管理器默认的配置文件
    
    
    