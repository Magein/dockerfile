### 说明
    
    Apache以模块的方式驱动php，无法分为两个容器去实现（可能我不知道），原因如下
     
    1. php安装的时候，在检查阶段，需要指定 --with-apxs2=apache安装路径
        
        附：apxs是apache1.x版本，apxs2是apache2.x版本，apxs文件在apache安装目录/bin/apxs
        
    2. apache启动的时候，配置文件中需要指定php的模块路径
    
### 版本
     
     httpd-2.4.29
     
### 安装

    遇到的错误：
     
        1. APR not found.  Please read the documentation.
         
         使用 yum 安装 :
         
         直接安装 apr-util-devel.x86_64。
          
         如果安装apr-devel.x86_64 下面还会出现apr-util的错误，所以直接安装apr-util-devel.x86_64、会自动安装依赖包：
        
         apr.x86_64 0:1.4.8-3.el7_4.1
         apr-devel.x86_64 0:1.4.8-3.el7_4.1
         apr-util.x86_64 0:1.5.2-6.el7 
         
        
         自己安装：需要安装apr和apr-util 检查的的时候使用--with-apr和 --with-apr-util指定路径即可
         
       2. configure: error: pcre-config for libpcre not found
       
          需要安装 pcre-devel.x86_64
### 扩展
    
     | support   | param                |
     |           |                      |
     | vhost     | --enable-vhost-alias |
     | rewrite   | --enable-rewrite     |
     
### 启动
    
    修改配置文件中的第196行，打开注释后启动
     
    安装目录/bin/apachectl start
     
    执行 curl localhost 能够正常访问，说明已经安装成功