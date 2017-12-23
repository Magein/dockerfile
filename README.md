### 版本
    
    docker  1.7.1
    centos  6.8
    kernel  2.6
    nginx   1.12.2
    php     7.1.11

### 基础镜像

    centos
    
### 安装
    
    需要用到的命令
    1. wget
    2. gcc
    3. make
    使用yum安装，注意yum源可用
    
### nginx
    
    需要安装 pcre-devel.x86_64 zlib-devel.x86_64
    
    使用yum安装，注意yum源可用
    
### php
    
    需要安装 libxml2-devel.x86_64
    
    使用yum安装，注意yum源可用
    
    扩展依赖：
        libcurl-devel.x86_64    curl
        openssl-devel.x86_64    openssl
        libjpeg-devel           gd库
        libpng-devel.x86_64     gd库
        libXpm-devel.x86_64     gd库
        freetype-devel.x86_64   gd库字体
        
    扩展：
    
        # fastCGI进程管理器
        --enable-fpm 
        
        # mysql数据库支持、使用mysqlnd驱动
        --with-mysqli=mysqlnd 
        --with-pdo-mysql=mysqlnd 
        
        # GD库支持
        --with-gd 
        -with-jpeg-dir 
        --with-png-dir 
        --with-zlib-dir 
        --with-xpm-dir 
        --with-freetype-dir 
        --enable-gd-native-ttf 
        
        # curl
        --with-curl
        
        # openssl
        --with-openssl
         
        # sockets
        --enable-sockets
        
### 启动
    
    建议不要在镜像中启动nginx和php-fpm
    
    把nginx.conf、php.ini、php-fpm.conf文件放到宿主机中，用挂载的方式把配置文件挂载到docker容器中
    
    1. 容器互联使用docker之定义网络实现
        docker network create magein
         
    2. 启动php、nginx是指定网络 --network magein
     
    3. 修改nginx.conf配置文件
     
        fastcgi_pass   php:9000;
        
        php为php-fpm容器启动的名称
        
    4. 修改www.config配置文件
        listen=[::]:9000
        
        
    
    
