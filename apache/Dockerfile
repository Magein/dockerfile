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
RUN yum -q -y install gcc wget make apr-util-devel.x86_64 pcre-devel.x86_64 \
    && wget -q -O $APACHE_PACKAGE_FILENAME $APACHE_DOWNLOAD_URL \
    && mkdir $APACHE_DIRECTORY \
    && tar -xzf $APACHE_PACKAGE_FILENAME -C $APACHE_DIRECTORY --strip-components 1 \
    && cd $APACHE_DIRECTORY \
    && ./configure --prefix=$APACHE_PREFIX > /dev/null \
    && make > /dev/null \
    && make install > /dev/null \
    && rm -rf /$APACHE_PACKAGE_FILENAME \
    && rm -rf /$APACHE_DIRECTORY \
    && yum -q -y remove gcc wget make

# expose 80
EXPOSE 80

# start apache
ENTRYPOINT $APACHE_PREFIX/sbin/apache -g "daemon off;"
