# from alpine 3.6
FROM alpine:3.6

RUN apk add --no-cache --virtual .fetch-deps gnupg wget

ENV PHP_VERSION 7.1.17

ENV PHP_URL "http://cn2.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror"
RUN wget -O php.tar.xz $PHP_URL

ENV PHP_SHA256 "1a784806866e06367f7a5c88775d239d6f30041c7ce65a8232d03a3d4de56d56"
RUN if [ -n $PHP_SHA256 ];then \
        echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
    fi;


ENV GPG_KEYS A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 528995BFEDFBA7191D46839EF9BA0ADA31CBD89E 1729F83938DA44E27BA0F4D3DBDB397470D12172
ENV PHP_ASC_URL "http://cn2.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror"
RUN set -xe; \
    \
    if [ -n $GPG_KEYS ];then \
        wget -O php.tar.xz.asc $PHP_ASC_URL; \
        export GNUPGHOME="$(mktemp -d)"; \
        for key in $GPG_KEYS;do \
            gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
        done; \
        gpg --batch --verify php.tar.xz.asc php.tar.xz; \
        rm -rf "$GNUPGHOME"; \
    fi;

RUN apk add --no-cache --virtual .build-deps \
        autoconf \
        dpkg-dev dpkg \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
        libxml2-dev

RUN mkdir -p php

RUN tar -Jxf php.tar.xz -C php --strip-components 1

RUN cd /php \
    && ./configure --enable-fpm

RUN cd /php \
    && make && make install

RUN ls /usr/local/bin

RUN ls /usr/local/sbin

RUN apk add --no-cache libmemcached-dev cyrus-sasl-dev

RUN pecl install memcached

RUN pecl install redis

RUN ls

