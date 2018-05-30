FROM alpine-php-5.6.35:latest

RUN apk add --no-cache --virtual .fetch-deps \
            gcc \
            g++ \
            make \
            autoconf

RUN pecl install redis && apk del .fetch-deps