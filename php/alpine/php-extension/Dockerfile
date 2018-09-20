FROM alpine-php:5.6

COPY php-ext /usr/local/bin/php-ext

RUN apk add --no-cache --virtual .dependent autoconf make gcc g++ && chmod u+x /usr/local/bin/php-ext && php-ext && apk del .dependent