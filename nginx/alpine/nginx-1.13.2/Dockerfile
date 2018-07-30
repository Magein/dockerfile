FROM alpine:3.6

MAINTAINER magein

ENV GPG_KEY B0F4253373F8F6F510D42178520A9993A1C052F8
ENV NGINX_VERSION nginx-1.13.2
ENV NGINX_PACKAGE $NGINX_VERSION.tar.gz
ENV NGINX_SIGN $NGINX_PACKAGE.asc
ENV NGINX_URL http://nginx.org/download/$NGINX_PACKAGE
ENV NGINX_ASC_URL http://nginx.org/download/$NGINX_SIGN

RUN apk add --no-cache --virtual .build-deps \
    gcc \
    g++ \
    wget \
    gnupg \
    make

RUN set -xe; \
    \
    wget -q -O $NGINX_PACKAGE $NGINX_URL; \
    \
    wget -q -O $NGINX_SIGN $NGINX_ASC_URL; \
    \
    export GNUPGHOME=$(mktemp -d) ; \
    \
    gpg --keyserver keyserver.ubuntu.com --recv-keys B0F4253373F8F6F510D42178520A9993A1C052F8; \
    \
    gpg --verify $NGINX_SIGN $NGINX_PACKAGE

RUN apk add --no-cache pcre-dev zlib-dev

RUN set xe; \
    mkdir /nginx ; \
    tar -xf $NGINX_PACKAGE -C /nginx --strip-components 1 ; \
    cd /nginx \
    && ./configure --sbin-path=/usr/sbin \
    && make \
    && make install \
    && make clean \
    && rm -rf nginx \
    && rm -rf $NGINX_PACKAGE \
    && apk del .build-deps

ENV ZONE="Asia/Shanghai"
RUN apk add --no-cache tzdata \
    && echo "$ZONE" > /etc/timezone \
    && rm -rf /usr/locatime \
    && ln -sf /usr/share/zoneinfo/$ZONE /etc/localtime \

EXPOSE 80

ENTRYPOINT nginx -g "daemon off;"