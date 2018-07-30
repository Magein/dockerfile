FROM alpine:3.6

# 编译 安装需要的命令
RUN apk add --no-cache --virtual .fetch-deps \
        autoconf \
        dpkg-dev dpkg \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
        gnupg \
        wget

# php支持扩展需要的依赖，不能删除
RUN apk add --no-cache --virtual .build-deps \
         libxml2-dev \
         curl-dev \
         openssl-dev \
         gd-dev \
         jpeg-dev \
         libpng-dev \
         freetype-dev

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
        --with-freetype-dir

ENV PHP_VERSION 7.1.17
ENV PHP_URL "http://cn2.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror"
ENV PHP_SHA256 "1a784806866e06367f7a5c88775d239d6f30041c7ce65a8232d03a3d4de56d56"
ENV GPG_KEYS A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 528995BFEDFBA7191D46839EF9BA0ADA31CBD89E 1729F83938DA44E27BA0F4D3DBDB397470D12172
ENV PHP_ASC_URL "http://cn2.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror"

RUN set -xe; \
    \
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
    fi;

RUN mkdir -p /php \
    && tar -Jxf php.tar.xz -C /php --strip-components=1 \
    && cd /php \
    && ./configure $PHP_SUPPORT --with-config-file-path=/usr/local/etc \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && make clean \
    && rm -rf /php \
    && rm -rf /php.tar.xz \
    && rm -rf /php.tar.xz.asc \
    && rm -rf /tmp/pear \
    && apk del .fetch-deps

RUN apk add --no-cache tzdata \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /usr/locatime \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

EXPOSE 9000

ENTRYPOINT php-fpm -F