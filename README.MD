### 说明
    
    所有的dockerfile文件都是自己摸索，学习得到的，会有很有多瑕疵，我也不知道能不能用在生产环境，只是用来切换开发环境使用。
     
    dockerfile中的镜像安装步骤都是基于在linux系统中安装的步骤，所以安装的步骤并不局限于生成docker镜像
     
    由于对linux并不是很熟练，所以并没有参考官方的镜像文件思路以及写法，以后有时间会去解读官方镜像
     
    docker不是虚拟机
    docker不是虚拟机
    docker不是虚拟机
    
    docker启动镜像得到一个容器，启动的只是一个进程。
     
    虽然主管意识正如上述所述，但是我写的dockerfile文件的思维还是局限于虚拟机安装，所以仅仅是一个学习过程，使用还是使用官方的php镜像 

### 关于版本

    技术在不断的更新，版本在不断的迭代，所以要时刻注意版本带来的问题，百度的资料可以参考，但是也不要使用拿来主义
     
    有可能因为版本不一样并且没有做向下兼容，资料就可能比较陈旧。导致遇到各种问题、然后在百度，在遇到问题，进入一个循环，提高了学习成本，当然这也不是没有好处，会让你记忆更加深刻
     
    docker17.x后的版本要求linux内核版本为 3.0以上，所以在安装的过程中一定要注意版本
    
### 启动
     
    dockerfile中最后启动 nginx php 都是都需要把程序放在前台执行
     
    启动 nginx ： nginx -g 'daemon off;'
     
    启动 php ：php-fpm -c php.ini的路径 -y php-fpm.conf的路径 -F
     
    附：
    
        1. 可以使用 nginx -h 、 php-fpm -h 查看帮助 
     
        2. 如果启动命令单纯是以后台守护(daemon)模式启动nginx，那么启动命令会立即结束，容器也会立即结束。
           其实只要在任何命令之后加一句 && cat，就会让这条命令卡在前台而不会结束，不是非得用daemon off（记录，尚未测试）
          
### 为什么要把后台程序放到前台执行?
    
    摘自：https://blog.lab99.org/post/docker-2016-07-14-faq.html
     
    docker不是虚拟机，docker不是虚拟机，docker不是虚拟机。
         
    容器只是进程。因此当执行 docker run 的时候，实际所做的只是启动一个进程，如果进程退出了，那么容器自然就终止了。
     
    更好的理解：
       1. ps -ef 观察第二行的PID，这里是进程号，记录最后一行的 PID  假如为：2195
       2. ls
       3. ps -ef 最后一行的PID应该是 2197 ，上面执行了 ls命令 所以进程号为 2196，为什么看不到 ls的 进程号，应为ls后，进程已经结束了，当前这里确保当前主机只有你一个人在操作
    ls命令跟启动php命令都是启动一个进程，命令执行完成后，这个进程就已经结束，不同的是，php启动后会在后台运行，生成一个新的进程，可以通过上面的方法测试，查看进程号的变化
     
    综上所述，启动nginx php 等后台进程的时候，需要保持在前台运行
    
### 为什么基于 Alpine 的镜像那么小？我可以都换成基于 Alpine 的镜像么？ 

    摘自：https://blog.lab99.org/post/docker-2016-07-14-faq.html  
   
    Alpine Linux 体积小是因为它所使用的基础命令来自精简的 busybox，并且它使用的是简化实现的 musl 作为库支持，而并非完整的 glibc。musl 体积小，但是有可能有不兼容的情况，因此一般不用 Alpine 的镜像，除非空间受限，体积大小很关键时才会使用。
    
    过去出现过兼容问题，但是随着 Docker 的使用，对 Alpine 的需求会越来越多，更多的兼容问题会被发现、修复，所以相信在未来这应该是个不错的选择。但是如果现在就要使用，一定要进行重复的测试，确保没有会影响到自己的 bug。
    
### 学习
    
    在编写dockerfile的时候，学习阶段可以 进行多个 RUN ，这种每一步的错误信息比较直观，并且再次编译的时候之前的会优先缓存获取，会节省等待的时间，如：
        
        // 安装php扩展需要的依赖
        RUN yum -y -q install m4 autoconf libmemcached-devel.x86_64
        
        # install memcached
        RUN $PHP_PREFIX/bin/pecl download memcached-2.1.0
        
        RUN mkdir $MEMCACHED_DIRECTORY \
            && tar -xf memcached-* -C $MEMCACHED_DIRECTORY --strip-components 1
        
        RUN cd $MEMCACHED_DIRECTORY \
            && $PHP_PREFIX/bin/phpize \
            && ./configure --with-php-config=$PHP_PREFIX/bin/php-config > /dev/null \
            && make -s \
            && make install
    
    当编译通过生成镜像后，就不建议使用多个RUN，应该合理分层。
    
    参照 ：https://blog.lab99.org/post/docker-2016-07-14-faq.html 
    
### 删除 
     
    在dockerfile中删除软件解压到的文件夹的时候  单独使用RUN rm -rf 会出现 directory not empty的错误
     
    经过测试不能单独使用如：RUN -rf -rf php-7.1.17  我测试测时候解压完即删除是可以的 如：tar -Jxf php-7.1.17.tar.xz && rm -rf php*
     
    因为文件已经在某一层占用了，所以删除失败，所以删除要在引用的层删除
    
### 挂载文件

    挂载文件的时候尽可能的挂载目录，挂载文件如果编辑了文件，可能会导致文件不一致
        
    使用vim编辑文件的时候，文件的inode修改前后不同。