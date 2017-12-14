# from centos
FROM docker-io/centos

# author magein
MAINTAINER magein

# nginx version
ENV NGINX_VERSION=nginx-1.12.2

# nginx path
ENV NGINX_PREFIX=/usr/local/nginx
ENV OUTPUT=/dev/null

# gcc、wget、make、zlib、pcre support
RUN yum -y install gcc wget make pcre-devel.x86_64 zlib-devel.x86_64 > $OUTPUT \

    && echo 'download '.$NGINX_VERSION \
    && wget -q http://nginx.org/download/$NGINX_VERSION.tar.gz \

    && echo 'tar '.$NGINX_VERSION \
    && tar -xzf $NGINX_VERSION.tar.gz \

    && echo 'install nginx to '.$NGINX_PREFIX \
    && cd $NGINX_VERSION
    && ./configure --prefix=$NGINX_PREFIX > $OUTPUT \
    && make > $OUTPUT_NULL \
    && make install > $OUTPUT \

    && echo 'remove nginx file' \
    && rm -rf $NGINX_VERSION* \

    && echo 'remove gcc、wget、make' \
    && yum -y remove gcc wget make > /dev/null

# 暴露80端口
EXPOSE 80

# 启动nginx
ENTRYPOINT /usr/local/nginx/sbin/nginx -g "daemon off;"
