FROM centos:7

MAINTAINER magein

ENV PHP_VERSION php-5.6.35
ENV PHP_PACKAGE_FILENAME $PHP_VERSION.tar.gz
ENV PHP_DOWNLOAD_URL http://cn2.php.net/distributions/$PHP_PACKAGE_FILENAME
ENV PHP_DIRECTORY $PHP_VERSION

ENV PHP_EXTENSION_DEPENDENT \
            libcurl-devel.x86_64 \
            openssl-devel.x86_64 \
            libjpeg-devel \
            libpng-devel.x86_64 \
            libXpm-devel.x86_64 \
            freetype-devel.x86_64 \
            libxml2-devel.x86_64

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

RUN yum -y -q install gcc wget make $PHP_EXTENSION_DEPENDENT \
    && wget -q -O $PHP_PACKAGE_FILENAME $PHP_DOWNLOAD_URL \
    && mkdir $PHP_DIRECTORY && tar -zxf $PHP_PACKAGE_FILENAME -C $PHP_DIRECTORY --strip-components 1 \
    && cd $PHP_DIRECTORY && ./configure $PHP_EXTENSION && make && make install \
    && rm -rf /tmp/pear /php* /var/cache/yum/
    && yum -q -y remove gcc wget make

RUN yum -y install autoconf libmemcached-devel

RUN ls /usr/include/libmemcached

RUN yum -y install zlib-devel

RUN pecl install memcached-2.1.0 && rm -rf /tmp/pear

EXPOSE 9000

ENTRYPOINT php-fpm -F
