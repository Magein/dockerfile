# from centos
FROM centos

# author magein
MAINTAINER magein

# php version
ENV PHP_VERSION php-7.1.11
# php extension
ENV PHP_EXT libcurl-devel.x86_64 \
            openssl-devel.x86_64 \
            libjpeg-devel \
            libpng-devel.x86_64 \
            libXpm-devel.x86_64 \
            freetype-devel.x86_64
# php support
ENV PHP_SUPPORT --enable-fpm \
                --with-mysqli=mysqlnd \
                --with-pdo-mysql=mysqlnd \
                --with-gd \
                -with-jpeg-dir \
                --with-png-dir \
                --with-zlib-dir \
                --with-xpm-dir \
                --with-freetype-dir \
                --enable-gd-native-ttf \
                --with-curl \
                --with-openssl \
                --enable-sockets

ENV OUTPUT /dev/null

# install command for gcc、wget、make
RUN echo 'install command' \
    && yum -y install gcc wget make libxml2-devel.x86_64

# install php extension
RUN echo 'install php extension' \
    && yum -y install $PHP_EXT

# donwload php
RUN echo 'download php' \
    && wget -q  http://cn2.php.net/distributions/$PHP_VERSION.tar.gz \
    && tar -xzf $PHP_VERSION.tar.gz

# install php
RUN cd $PHP_VERSION \
    && ./configure --prefix=/usr/local/php $PHP_SUPPORT > $OUTPUT \
    && make > $OUTPUT \
    && make install > $OUTPUT

# php config
RUN cd $PHP_VERSION && cp php.ini-production /usr/local/php/lib/php.ini \
    && cd /usr/local/php/etc && cp php-fpm.conf.default php-fpm.conf \
    && cd /usr/local/php/etc/php-fpm.d && cp www.conf.default www.conf

# remove file and command
RUN echo 'remove nginx file and command' \
    && rm -rf $PHP_VERSION* \
    && yum -y install gcc wget make

# expose 9000
EXPOSE 9000

# 启动php-fpm
ENTRYPOINT /usr/local/php/sbin/php-fpm -c /usr/local/php/lib/php.ini -y /usr/local/php/etc/php-fpm.conf -F
