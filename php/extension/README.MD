### memcache 和 memcached

    1.memcached 是memcache的升级版
     
    2.memcached 在window下不能使用
     
    使用pecl安装，pecl参考php-devel+pear.MD 
     
    安装memcached需要libmemcached的支持：
     
    yum -y install libmemcached-devel.x86_64
     
    pecl install memcached 
     
    使用上述方式安装，会出现一个问题让你回答，需要使用回车键
     
    如果是在docker中没有办法进行交互，所以需要使用一下方式安装
    
    // 下载memcached，指定版本 package-version，下载memcached-3.0.2
    pecl download memcached
     
    // 创建解压文件目录，因为下载的版本是latest版本，所以文件名字会变化，
    // 当你不知道是那个版本的时候，解压到memcached即可
    mkdir memcached
     
    // 由于不知道版本名称，所以使用通配符*,指定解压到memcached目录 
    tar -xf memcached-* -C memcached --strip-components 1
     
    // 进入目录
    cd memcached
     
    // 生成configure文件,phpize路径要指定正确
    phpize
     
    // 开始检查
    ./configure --with-php-config=xxx
     
    // 编译、安装
    make && make install
     
    生成的.so文件取决于您的配置文件中的 extension_dir 选项
    
### redis 

    安装形式跟安装memcached一样，