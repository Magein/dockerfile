FROM alpine:3.6

# 修改 apline的镜像源为阿里云的镜像源 加快构建速度
RUN echo "https://mirrors.aliyun.com/alpine/v3.6/main/" > /etc/apk/repositories

# php支持的扩展列表
ENV PHP_SUPPORT \
        --enable-fpm \
        --enable-mysqlnd \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-openssl \
        --enable-mbstring \
        --disable-cgi \
        --with-curl \
        --with-gd \
        --with-jpeg-dir \
        --with-png-dir \
        --with-zlib-dir \
        --with-freetype-dir \
        --enable-sockets \
        --enable-zip

ENV PHP_VERSION 5.6.36
ENV PHP_URL "http://cn2.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror"
ENV PHP_SHA256 "18f536bf548e909b4e980379d0c4e56d024b2b1eb1c9768fd169360491f1d6dd"
ENV GPG_KEYS 6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3 0BD78B5F97500D450838F95DFE857D9A90D90EC1
ENV PHP_ASC_URL "http://cn2.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror"

RUN set -xe; \
    \
    apk add --no-cache \
                gnupg \
                wget \

    ;\
    wget -O php.tar.xz $PHP_URL ; \
    \
    if [ -n $PHP_SHA256 ];then \
        echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
    fi; \
    \
    if [ -n $GPG_KEYS ];then \
        wget -O php.tar.xz.asc $PHP_ASC_URL; \
        export GNUPGHOME="$(mktemp -d)"; \
        for key in $GPG_KEYS;do \
            gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
        done; \
        gpg --batch --verify php.tar.xz.asc php.tar.xz; \
        rm -rf "$GNUPGHOME"; \
    fi; \
    apk del gnupg wget

RUN set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data

RUN apk add --no-cache \
         re2c \
         autoconf \
         g++ \
         gcc \
         make \
         libxml2-dev \
         curl-dev \
         openssl-dev \
         gd-dev \
         jpeg-dev \
         libpng-dev \
         freetype-dev \
    && mkdir -p /php \
    && tar -Jxf php.tar.xz -C /php --strip-components=1 \
    && cd /php \
    && ./configure $PHP_SUPPORT --with-config-file-path=/usr/local/etc -with-fpm-user=www-data --with-fpm-group=www-data \
    && make \
    && make install \
    && make clean \
    && rm -rf /php \
    && rm -rf /php.tar.xz \
    && rm -rf /php.tar.xz.asc \
    && rm -rf /tmp/pear \
    && apk del re2c autoconf g++ gcc make

# 修改时间
RUN apk add --no-cache tzdata \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /usr/locatime \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

EXPOSE 9000

ENTRYPOINT php-fpm -F