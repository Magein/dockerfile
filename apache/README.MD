### 说明

    linux下推荐使用nginx，这里安装apache+php仅供学习，并且安装的思维方式完全是按照在linux中安装的方式，
     
    Apache以模块的方式驱动php，无法分为两个容器去实现（可能我不知道），原因如下
     
    1. php安装的时候，在检查阶段，需要指定 --with-apxs2=apache安装路径
        
       apxs是apache1.x版本，apxs2是apache2.x版本，apxs文件在apache安装目录/bin/apxs
       
       ./configure --prefix=xxx --with-apxs2=apache安装目录/bin/apxs
        
       在最后一步执行make install 后，安装成功会看到
       
       `
       Installing PHP SAPI module:       apache2handler
       /usr/local/apache/build/instdso.sh SH_LIBTOOL='/usr/lib64/apr-1/build/libtool' libphp7.la /usr/local/apache/modules
       /usr/lib64/apr-1/build/libtool --mode=install install libphp7.la /usr/local/apache/modules/
       libtool: install: install .libs/libphp7.so /usr/local/apache/modules/libphp7.so
       libtool: install: install .libs/libphp7.lai /usr/local/apache/modules/libphp7.la
       libtool: install: warning: remember to run `libtool --finish /root/php-7.1.11/libs'
       chmod 755 /usr/local/apache/modules/libphp7.so
       [activating module `php7' in /usr/local/apache/conf/httpd.conf]
       Installing shared extensions:     /usr/local/apache-php7/lib/php/extensions/no-debug-zts-20160303/
       Installing PHP CLI binary:        /usr/local/apache-php7/bin/
       Installing PHP CLI man page:      /usr/local/apache-php7/php/man/man1/
       Installing phpdbg binary:         /usr/local/apache-php7/bin/
       Installing phpdbg man page:       /usr/local/apache-php7/php/man/man1/
       Installing PHP CGI binary:        /usr/local/apache-php7/bin/
       Installing PHP CGI man page:      /usr/local/apache-php7/php/man/man1/
       Installing build environment:     /usr/local/apache-php7/lib/php/build/
       Installing header files:          /usr/local/apache-php7/include/php/
       Installing helper programs:       /usr/local/apache-php7/bin/
       `
       上面有一句 chmod 755 /usr/local/apache/modules/libphp7.so 这个文件需要在apache的配置中加载 
        
    2. apache启动的时候，配置文件中需要指定php的模块路径
     
     在 httpd.conf中引入libphp7模块：LoadModule php7_module        modules/libphp7.so
     
     附：一般会默认加上 上面有一句：[activating module `php7' in /usr/local/apache/conf/httpd.conf]
      
     这个是激活模块，会默认在配置文件中加上这个php7模块，但是要是使用宿主机中的配置文件替代容器中的文件，这一句需要手动加上
    
    
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
          
       3. 安装php出现：
       
            Configuring SAPI modules
            checking for Apache 2.0 handler-module support via DSO through APXS... 
            
            Sorry, I cannot run apxs.  Possible reasons follow:
            
            1. Perl is not installed
            2. apxs was not found. Try to pass the path using --with-apxs2=/path/to/apxs
            3. Apache was not built using --enable-so (the apxs usage page is displayed)
            
            使用yum安装应该在安装apache之前安装。我测试过先安装apache，在安装php的时候出现这个错误，使用yum安装了perl，再次检查还是会出现这个错误，
### 扩展
    
     | support   | param                |
     |           |                      |
     | vhost     | --enable-vhost-alias |
     | rewrite   | --enable-rewrite     |
     
### 运行镜像启动apache
    
    dockerfile文件中启动：
        /bin/apachectl -DFOREGROUND 
        这里使用-DFOREGROUND 把服务放到前台自动，一些资料中都是使用文件的形式，然后copy进来，这里我不知道这样写的好处是什么，我就直接使用指定-DFOREGROUND参数的形式启动了
    
    linux正常安装启动：
     
    修改配置文件中的第196行，打开注释
     
    安装目录/bin/apachectl start
     
    执行 curl localhost 能够正常访问，说明已经安装成功
    
### 支持php
    
    需要在apache的配置文件中加载 libphpx.so
    
    并且支持php文件：AddType application/x-httpd-php .php