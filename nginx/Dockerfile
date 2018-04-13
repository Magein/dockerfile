# from the centso system and version 7
FROM centos:centos7

# author magein
MAINTAINER magein

# nginx version
ENV NGINX_VERSION nginx-1.12.2

# nginx installation location
ENV NGINX_PREFIX /usr/local/nginx

# nginx download url
ENV NGINX_DOWNLOAD_URL http://nginx.org/download/nginx-1.12.2.tar.gz

# nginx package filename
ENV NGINX_PACKAGE_FILENAME nginx-1.12.2.tar.gz

# nginx directory
ENV NGINX_DIRECTORY nginx-1.12.2

# gcc、wget、make、zlib、pcre support
RUN yum -q -y install gcc wget make pcre-devel.x86_64 zlib-devel.x86_64 \
    && wget -q -O $NGINX_PACKAGE_FILENAME $NGINX_DOWNLOAD_URL \
    && mkdir $NGINX_DIRECTORY \
    && tar -xzf $NGINX_PACKAGE_FILENAME -C $NGINX_DIRECTORY --strip-components 1 \
    && cd $NGINX_DIRECTORY \
    && ./configure --prefix=$NGINX_PREFIX > /dev/null \
    && make -s \
    && make install \
    && rm -rf /$NGINX_PACKAGE_FILENAME \
    && rm -rf /$NGINX_DIRECTORY \
    && yum -q -y remove gcc wget make

# expose 80
EXPOSE 80

# start nginx
ENTRYPOINT $NGINX_PREFIX/sbin/nginx -g "daemon off;"
