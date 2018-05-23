#!/bin/sh

source ./common.sh
source ./config.sh

# 创建目录
conf="/usr/local/conf"
web="/var/www"
nginx_error_log="/var/log/nginx/"
php_fpm_error_log="/var/log/php/"

makeDirectory "$conf" "$web" "$nginx_error_log" "$php_fpm_error_log"

# 下载镜像
nginx_registry="registry.cn-hangzhou.aliyuncs.com/magein/alpine-nginx-1.13.2"
php_registry="registry.cn-hangzhou.aliyuncs.com/magein/alpine-php-7.1.17"

registry "$nginx_registry" "$php_registry"

# 生成配置文件
ini     "$conf/php.ini"
fpm     "$conf/php-fpm.conf"
www     "$conf/php-fpm.d"
nginx   "$conf/nginx.conf"

composer_file="$PWD/yml"

yml(){
    makeFile "$composer_file"
    {
        echo "version: \"3\"
services:
  php:
    image: $php_registry
    ports:
      - 9000:9000
    volumes:
      - $conf:/usr/local/etc/
      - $php_fpm_error_log:/usr/local/var/log
      - $web:/usr/local/nginx/html
    deploy:
      replicas: 1
  nginx:
    image: $nginx_registry
    ports:
      - 80:80
    volumes:
      - $conf/nginx.conf:/usr/local/nginx/conf/nginx.conf
      - $nginx_error_log:/usr/local/nginx/logs/
      - $web:/usr/local/nginx/html
    deploy:
      replicas: 1
"
    } | tee "$composer_file"
}

yml

docker swarm init > /dev/null

docker stack deploy -c yml web