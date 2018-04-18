# from the centso system and version 7
FROM centos:centos7

# author magein
MAINTAINER magein

# apache version
ENV APACHE_VERSION httpd-2.4.29

# apache package filename
ENV APACHE_PACKAGE_FILENAME $APACHE_VERSION.tar.gz

# apache download url
ENV APACHE_DOWNLOAD_URL http://mirrors.hust.edu.cn/apache/httpd/$APACHE_PACKAGE_FILENAME

# apache installation location
ENV APACHE_PREFIX /usr/local/apache

# apache directory
ENV APACHE_DIRECTORY $APACHE_VERSION

# gcc、wget、make、apr-util-devel.x86_64
RUN yum -q -y install gcc wget make apr-util-devel.x86_64 pcre-devel.x86_64 openssl-devel.x86_64 perl\
    && wget -q -O $APACHE_PACKAGE_FILENAME $APACHE_DOWNLOAD_URL \
    && mkdir $APACHE_DIRECTORY \
    && tar -xzf $APACHE_PACKAGE_FILENAME -C $APACHE_DIRECTORY --strip-components 1 \
    && cd $APACHE_DIRECTORY \
    && ./configure --prefix=$APACHE_PREFIX --enable-so --enable-rewrite --enable-ssl > /dev/null \
    && make > /dev/null \
    && make install > /dev/null \
    && rm -rf /$APACHE_PACKAGE_FILENAME \
    && rm -rf /$APACHE_DIRECTORY \
    && rm -rf /var/cache/yum/
# php version php-5.6.35
ENV PHP_VERSION php-5.6.35

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
            libjpeg-devel \
            libpng-devel.x86_64 \
            libXpm-devel.x86_64 \
            freetype-devel.x86_64 \
            libxml2-devel.x86_64

# php extension
ENV PHP_EXTENSION \
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

# keep quiet install php_extension
RUN yum -q -y install $PHP_EXTENSION_DEPENDENT \
    && wget -q -O $PHP_PACKAGE_FILENAME http://cn2.php.net/distributions/$PHP_PACKAGE_FILENAME \
    && mkdir $PHP_DIRECTORY \
    && tar -zxf $PHP_PACKAGE_FILENAME -C $PHP_DIRECTORY --strip-components 1 \
    && cd $PHP_DIRECTORY \
    && ./configure --prefix=$PHP_PREFIX --with-apxs2=$APACHE_PREFIX/bin/apxs > /dev/null \
    && make -s \
    && make install \
    && cp php.ini-development $PHP_PREFIX/lib/php.ini \
    && rm -rf /$PHP_PACKAGE_FILENAME \
    && rm -rf /$PHP_DIRECTORY \
    && yum -q -y remove gcc wget make

# expose 80
EXPOSE 80

# start apache
ENTRYPOINT $APACHE_PREFIX/bin/apachectl -DFOREGROUND
