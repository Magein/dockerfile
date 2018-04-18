# from the centso system and version 7
FROM centos:centos7

# author magein
MAINTAINER magein

# nginx version
ENV NGINX_VERSION nginx-1.12.2

# nginx package filename
ENV NGINX_PACKAGE_FILENAME $NGINX_VERSION.tar.gz

# nginx download url
ENV NGINX_DOWNLOAD_URL http://nginx.org/download/$NGINX_PACKAGE_FILENAME

# nginx installation location
ENV NGINX_PREFIX /usr/local/nginx

# nginx directory
ENV NGINX_DIRECTORY $NGINX_VERSION

# gcc、wget、make、zlib、pcre support
RUN yum -q -y install gcc wget make pcre-devel.x86_64 zlib-devel.x86_64 \
    && wget -q -O $NGINX_PACKAGE_FILENAME $NGINX_DOWNLOAD_URL \
    && mkdir $NGINX_DIRECTORY \
    && tar -xzf $NGINX_PACKAGE_FILENAME -C $NGINX_DIRECTORY --strip-components 1 \
    && cd $NGINX_DIRECTORY \
    && ./configure --prefix=$NGINX_PREFIX > /dev/null \
    && make -s \
    && make install \
    && cp php.ini-development $PHP_PREFIX/lib/php.ini \
    && rm -rf /$NGINX_PACKAGE_FILENAME \
    && rm -rf /$NGINX_DIRECTORY \
    && yum -q -y remove gcc wget make \
    && rm -rf /var/cache/yum/
# expose 80
EXPOSE 80

# start nginx
ENTRYPOINT $NGINX_PREFIX/sbin/nginx -g "daemon off;"
