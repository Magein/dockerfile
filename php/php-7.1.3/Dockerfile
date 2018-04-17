# from the centso system and version 7
FROM centos:centos7

# author magein
MAINTAINER magein

# php version php-7.1.13
ENV PHP_VERSION php-7.1.13

# php compression package filename
ENV PHP_PACKAGE_FILENAME $PHP_VERSION.tar.gz

# php downloads the url
ENV PHP_DOWNLOAD_URL http://cn2.php.net/distributions/$PHP_PACKAGE_FILENAME

# dicectory name after unzip
ENV PHP_DIRECTORY $PHP_VERSION

# php installation location
ENV PHP_PREFIX /usr/local/php/

# php.ini location
ENV PHP_INI $PHP_PREFIX/lib/

# php extension dependent
ENV PHP_EXTENSION_DEPENDENT \
            libcurl-devel.x86_64 \
            openssl-devel.x86_64 \
            libjpeg-devel \
            libpng-devel.x86_64 \
            libXpm-devel.x86_64 \
            freetype-devel.x86_64 \
            libxml2-devel.x86_64

# php extension
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

# keep quiet install command for gcc、wget、make
RUN yum -y -q install gcc wget make $PHP_EXTENSION_DEPENDENT \
    && wget -q -O $PHP_PACKAGE_FILENAME $PHP_DOWNLOAD_URL \
    && mkdir $PHP_DIRECTORY \
    && tar -zxf $PHP_PACKAGE_FILENAME -C $PHP_DIRECTORY --strip-components 1 \
    && cd $PHP_DIRECTORY \
    && ./configure --prefix=$PHP_PREFIX --with-config-file-path=$PHP_INI $PHP_EXTENSION > /dev/null \
    && make -s \
    && make install \
    && rm -rf /$PHP_PACKAGE_FILENAME \
    && rm -rf /$PHP_DIRECTORY \
    && yum -q -y remove gcc wget make

# expose 9000
EXPOSE 9000

# start php-fpm
# -F force to stay in foreground, and ignore daemonize option from config file
ENTRYPOINT $PHP_PREFIX/sbin/php-fpm -c $PHP_PREFIX/lib/php.ini -y $PHP_PREFIX/etc/php-fpm.conf.default -F
