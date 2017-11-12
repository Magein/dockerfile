# 基础镜像为centos
FROM centos

# 创建、维护人员  magein
MAINTAINER magein

# 设置环境变量
# 设置安装版本
ENV PHP_VERSION=php-7.1.11

# 安装编译所需要的命令 gcc、wget、make
RUN yum -y install gcc wget make

# 安装php依赖
RUN yum -y install libxml2-devel.x86_64

# 安装php扩展  curl openss libjpeg-devel libpng-devel.x86_64 libXpm-devel.x86_64 freetype-devel.x86_64 freetype-devel.x86_64
RUN yum -y install libcurl-devel.x86_64 openssl-devel.x86_64 libjpeg-devel libpng-devel.x86_64 libXpm-devel.x86_64 freetype-devel.x86_64

# 官网下载php
RUN wget -q  http://cn2.php.net/distributions/PHP_VERSION.tar.gz

# 解压php包
RUN tar -xzf $PHP_VERSION.tar.gz

# 编译、安装php
RUN cd php-7.1.11 && ./configure --prefix=/usr/local/php7.1.11 --enable-fpm --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd -with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --enable-gd-native-ttf --with-curl --with-openssl --enable-sockets && make > /dev/null && make install > /dev/null

# 删除php压缩包和文件
RUN rm -rf $PHP_VERSION*
