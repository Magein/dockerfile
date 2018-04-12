# from centos
FROM centos:centos7

# author magein
MAINTAINER magein

# php version
ENV PHP_VERSION php-5.6.35

# download php url
ENV DOWNLOAD_PHP_URL http://cn2.php.net/distributions/php-5.6.35.tar.gz

# download php filename
ENV DOWNLOAD_PHP_FILENAME php-5.6.35.tar.gz

# php extension
ENV PHP_EXT libcurl-devel.x86_64 \
            openssl-devel.x86_64 \
            libjpeg-devel \
            libpng-devel.x86_64 \
            libXpm-devel.x86_64 \
            freetype-devel.x86_64 \
            libxml2-devel.x86_64
# php support
ENV PHP_SUPPORT --enable-fpm \
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

ENV OUTPUT /dev/null

# keep quiet install command for gcc、wget、make
RUN yum -y -q install gcc wget make $PHP_EXT

# keep quiet download php
RUN wget -q  $DOWNLOAD_PHP_URL && tar -zxf $DOWNLOAD_PHP_FILENAME

# install php
RUN cd $PHP_VERSION \
    && ./configure --prefix=/usr/local/php5.6 $PHP_SUPPORT > $OUTPUT \
    && make > $OUTPUT \
    && make install > $OUTPUT

# php config
# php5.6和php7.x fpm配置文件有所不同
# php5.6的fpm配置文件是一个文件 在php安装目录下的etc/目录下
# php7.x系列的fpm配置文件分开了，etc/目录下php-fpm.conf.default是主进程配置文件，php-fpm.d目录下面是控制子进程的配置文件
# 这里安装的5.6版本的
RUN cd $PHP_VERSION && cp php.ini-production /usr/local/php5.6/lib/php.ini \
    && cd /usr/local/php5.6/etc && cp php-fpm.conf.default php-fpm.conf

# remove file and command
RUN echo 'remove nginx file and command' \
    && rm -rf $PHP_VERSION* \
    && yum remove -y gcc wget make

# expose 9000
EXPOSE 9000

# 启动php-fpm
ENTRYPOINT /usr/local/php/sbin/php-fpm -c /usr/local/php/lib/php.ini -y /usr/local/php/etc/php-fpm.conf -F
