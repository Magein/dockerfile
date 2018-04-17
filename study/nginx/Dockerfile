# from centos
FROM centos

# author magein
MAINTAINER magein

# nginx version
ENV NGINX_VERSION=nginx-1.12.2

# nginx path
ENV NGINX_PREFIX=/usr/local/nginx
ENV OUTPUT=/dev/null

# gcc、wget、make、zlib、pcre support
RUN yum -y install gcc wget make pcre-devel.x86_64 zlib-devel.x86_64 > $OUTPUT

# download nginx
RUN echo 'download '$NGINX_VERSION \
    && wget -q http://nginx.org/download/$NGINX_VERSION.tar.gz \
    && echo 'tar '.$NGINX_VERSION \
    && tar -xzf $NGINX_VERSION.tar.gz

# install nginx
RUN echo 'install nginx to '$NGINX_PREFIX \
    && cd $NGINX_VERSION \
    && ./configure --prefix=$NGINX_PREFIX > $OUTPUT \
    && make > $OUTPUT \
    && make install > $OUTPUT

# remove file and command
RUN echo 'remove nginx file and command' \
    && rm -rf $NGINX_VERSION* \
    && yum -y remove gcc wget make > /dev/null

# expose 80
EXPOSE 80

# start nginx
ENTRYPOINT /usr/local/nginx/sbin/nginx -g "daemon off;"
