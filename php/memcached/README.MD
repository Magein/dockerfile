### memcache 和 memcached

    1.memcached 是memcache的升级版
     
    2.memcached 在window下不能使用
     
    使用pecl安装，pecl参考php-devel+pear.MD 
     
    安装memcached需要libmemcached的支持：
     
    yum -y install libmemcached-devel.x86_64
     
    pecl install memcached 
     
    使用上述方式安装，会出现一个问题让你回答，需要使用回车键
     
    如果是在docker中没有办法进行交互，所以需要使用以下方式安装
    
    // 根据php版本选择memcached版本，php7.x 系列选择3.0.0以上的版本，测试php5.6搭配2.0.1
    // 如果版本搭配不正确，会出现错误：#include "Zend/zend_smart_str.h"
    // 下载memcached，指定版本 package-version，下载memcached-3.0.2
    // 也可以使用wget 在pecl网站下载
    pecl download memcached
     
    // 创建解压文件目录，因为下载的版本是latest版本，所以文件名字会变化，
    // 当你不知道是那个版本的时候，解压到memcached即可
    mkdir memcached
     
    // 由于不知道版本名称，所以使用通配符*,指定解压到memcached目录 
    tar -xf memcached-* -C memcached --strip-components 1
     
    // 进入目录
    cd memcached
     
    // 生成configure文件,phpize路径要指定正确,这里需要安装 m4 和 autoconf 可以使用 yum 安装
    phpize
     
    // 开始检查
    ./configure --with-php-config=xxx
     
    // 编译、安装
    make && make install
     
    生成的.so文件取决于您的配置文件中的 extension_dir 选项
    
### redis 

    安装形式跟安装memcached一样，
    
### 出错
    	make: *** [Makefile:181: php_memcached.lo] Error 1
    	 
      	make: *** [php_memcached.lo] Error 1
      	 
      	#include "Zend/zend_smart_str.h"
      	 
      	1. 版本选择错误
      	    5.6 搭配2.1.0
      	    7.x 搭配3.x
      	    
        2. 缺少依赖
            cyrus-sasl