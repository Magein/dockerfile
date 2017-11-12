### 基础镜像
    docker官网centos镜像
    
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
    
    
