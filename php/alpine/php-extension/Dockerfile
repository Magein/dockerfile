FROM alpine-php:5.6

RUN apk add --no-cache --virtual .dependent autoconf make gcc g++

COPY php-ext /usr/local/bin/php-ext

RUN chmod u+x /usr/local/bin/php-ext && php-ext && apk del .dependent