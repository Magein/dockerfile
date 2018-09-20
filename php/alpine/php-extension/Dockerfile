FROM alpine-php:5.6

COPY php-ext /usr/local/bin/php-ext

RUN chmod u+x /usr/local/bin/php-ext && php-ext && alpine-deps -d build