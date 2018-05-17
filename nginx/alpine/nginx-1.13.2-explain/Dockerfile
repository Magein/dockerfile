FROM alpine:3.6

MAINTAINER magein

RUN apk add --no-cache --virtual .build-deps \
    gcc \
    g++ \
    wget \
    gnupg \
    make \
    pcre-dev \
    zlib-dev

ENV NGINX_VERSION nginx-1.13.2
ENV NGINX_PACKAGE nginx-1.13.2.tar.gz
ENV NGINX_SIGN $NGINX_PACKAGE.asc
ENV NGINX_URL http://nginx.org/download/$NGINX_PACKAGE
ENV NGINX_ASC_URL http://nginx.org/download/$NGINX_SIGN
ENV GPG_KEY B0F4253373F8F6F510D42178520A9993A1C052F8

RUN wget -q -O $NGINX_PACKAGE $NGINX_URL

RUN wget -q -O $NGINX_SIGN $NGINX_ASC_URL

RUN set -xe; \
    \
    export GNUPGHOME=$(mktemp -d) ;\
    \
    gpg --keyserver keyserver.ubuntu.com --recv-keys B0F4253373F8F6F510D42178520A9993A1C052F8;\
    \
    gpg --verify $NGINX_SIGN $NGINX_PACKAGE

RUN apk add --no-cache

RUN set xe; \
    mkdir /nginx ; \
    tar -xf $NGINX_PACKAGE -C /nginx --strip-components 1 ; \
    cd /nginx \
    && ./configure --sbin-path=/usr/sbin \
    && make \
    && make install \
    && make clean

RUN ls /usr/local/nginx


