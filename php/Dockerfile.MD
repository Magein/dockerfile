# 基础镜像是centos的官方镜像,版本7
FROM centos:centos7

# 作者
MAINTAINER magein

# 以下定义了一些环境变量，
# 在docker中，ENV 定义的变量可以在docker run 的时候通过 -v 改变
# 我这里使用的变量大多都是出自平时编程的习惯，并不会通过 -v 去改变什么，当然了这里也不限制去修改哦

# 这里安装的是php的版本，
ENV PHP_VERSION php-5.6.35

# php安装路径
ENV PHP_PREFIX /usr/local/php/

# php配置文件php.ini的配置文件
ENV PHP_INI $PHP_PREFIX/lib/

# php文件包下载到容器中的名字
ENV PHP_PACKAGE_FILENAME $PHP_VERSION.tar.gz

# php文件的下载链接
ENV PHP_DOWNLOAD_URL http://cn2.php.net/distributions/$PHP_PACKAGE_FILENAME

# php文件包解压后的目录名称
ENV PHP_DIRECTORY $PHP_VERSION

# 我安装了一些常用的扩展，安装这些扩展的时候需要依赖一些开发包，所以直接通过 yum 进行安装，如果编译失败，可以查看相关版本
ENV PHP_EXTENSION_DEPENDENT \
            libcurl-devel.x86_64 \
            openssl-devel.x86_64 \
            libjpeg-devel \
            libpng-devel.x86_64 \
            libXpm-devel.x86_64 \
            freetype-devel.x86_64 \
            libxml2-devel.x86_64

# php常用的一些扩展
# 我使用php的时候喜欢使用 xdebug 但是并没有安装
# xdebug，memcached、redis这些都可以用过 pecl 安装
# 下面这里扩展都是可以配置的，满足基本的开发需求，更多扩展可以在解压后的php目录下使用./confgure --help查看
ENV PHP_EXTENSION \
                --enable-fpm \
                --with-mysqli=mysqlnd \
                --with-pdo-mysql=mysqlnd \
                --with-gd \
                --with-jpeg-dir \
                --with-png-dir \
                --with-zlib-dir \
                --with-xpm-dir \
                --with-freetype-dir \
                --enable-gd-native-ttf \
                --with-curl \
                --with-openssl \
                --enable-sockets \
                --enable-mbstring

# 这里下载需要用到的命令，以及php扩展依赖的开发包了
# 我都使用静默的方式
# 下面每行注释是为了阅读，理解，在编译的时候按照规范来比较好了
# 如果是学习的话，可以把下面的命令分成多个RUN执行，了解每一步干了什么

# 安装gcc  wget make php扩展依赖包
RUN yum -y -q install gcc wget make $PHP_EXTENSION_DEPENDENT \

    # 使用静默的方式(-q)下载压缩的php安装包($PHP_DOWNLOAD_URL)，并且指定包的名称(-O $PHP_PACKAGE_FILENAME)
    && wget -q -O $PHP_PACKAGE_FILENAME $PHP_DOWNLOAD_URL \

    # 创建php解压后的文件存放目录，这一步可以不要，直接写使用解压后的文件名称即可，这里创建的文件夹和解压后生成的文件夹是一样的
    # 使用环境变量+创建文件夹的形式是出自编程的习惯，（下面cd 可 rm 都用到了这个值）
    && mkdir $PHP_DIRECTORY \

    # 解压php压缩包文件到指定的目录
    # -C 是指定解压到目录，
    # --strip-components这参数跟重要， 意思是解压时从文件名中清除 NUMBER 如果不带，解压出来的的目录就变成 /$PHP_DIRECTORY/php-5.6.35/ 多了一级目录
    && tar -zxf $PHP_PACKAGE_FILENAME -C $PHP_DIRECTORY --strip-components 1 \

    # 进入到php目录进行编译
    # docker用 连贯操作需要使用 && 连接
    # 不能使用多个 RUN 去操作，如：我要进入到某个目录，查看文件
    #   RUN cd /xxx/xxx
    #   RUN ls
    # 上面这个虽然执行没错，但是ls后的结果并不是 /xxx/xxx的结果，而是当前目录的结果
    # 应该使用 RUN cd /xxx/xxx && ls
    && cd $PHP_DIRECTORY \

    # 开始检测相关支持（比如检测是否有gcc、libxml2,没有就会出现错误，这也是上面安装的原因，至于gcc、libxml2有什么用，请百度）
    # 并且将检测结果输入到空设备中
    && ./configure --prefix=$PHP_PREFIX --with-config-file-path=$PHP_INI $PHP_EXTENSION > /dev/null \

    # 开始编译，使用静默方式，安静：quiet  寂静的、无声的：silent 所以有些命令是-q 有些是-s
    # make是从makefile中读取指令，然后编译，
    && make -s \

    # 编译完成后，安装
    && make install \

    # 删除php压缩包文件
    && rm -rf /$PHP_PACKAGE_FILENAME \
    # 删除php目录
    && rm -rf /$PHP_DIRECTORY \
    # 移除相关命令
    && yum -q -y remove gcc wget make

# 暴露容器的9000端口，宿主机可以映射进来
EXPOSE 9000

# 启动 php-fpm
# 参数 -F 的解释：
#   使用命令：php-fpm --help | grep F
#   可以看到：force to stay in foreground, and ignore daemonize option from config file
#   意思是：忽略配置文件中的daemonize选项，迫使程序停留在前台
#
# 这里是有一个关于docker的概念需要强调一下：
#  docker不是虚拟机,docker启动的容器是一个进程
#  docker不是虚拟机,docker启动的容器是一个进程
#  docker不是虚拟机,docker启动的容器是一个进程
# 启动 php 进程的命令结束后（可以继续输入其他的命令继续工作，php服务在后台执行），那么这个容器也就终止了，所以要要把后台服务服务放到前台执行（已经无法在当前终端输入命令继续工作了）
#
# 更好的理解：
#   ps -ef 观察第二行的PID，这里是进程号，记录最后一行的 PID  假如为：2195
#   ls
#   ps -ef 最后一行的PID应该是 2197 ，上面执行了 ls命令 所以进程号为 2196，为什么看不到 ls的 进程号，应为ls后，进程已经结束了，当前这里确保当前主机只有你一个人在操作
# ls命令跟启动php命令都是启动一个进程，命令执行完成后，这个进程就已经结束，不同的是，php启动后会在后台运行，生成一个新的进程，可以通过上面的方法测试，查看进程号的变化
#
# 综上所述，启动nginx php 等后台进程的时候，需要保持在前台运行
#
ENTRYPOINT $PHP_PREFIX/sbin/php-fpm -c $PHP_PREFIX/lib/php.ini -y $PHP_PREFIX/etc/php-fpm.conf.default -F
