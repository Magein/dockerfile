#!/usr/bin/env bash

if [ ! -n $1 ]; then
    base="$1"
else
    base="/usr/local/conf"
fi

makeDirectory(){
    if [ ! -d "$1" ];then
        mkdir -p "$1"
    fi
}

makeFile(){
    if [ ! -f "$1" ];then
        touch "$1"
    fi
}

makeDirectory "$base"

ini(){
    filePath="$base/php.ini"
    makeFile "$filePath"
    {
        echo "[php]"
        echo "display_errors = On"
    } | tee "$filePath"
}

fpm(){

    filePath="$base/php-fpm.conf"
    makeFile "$filePath"
    {
        echo "[global]"
        echo "pid = run/php-fpm.pid"
        echo "error_log = log/php-fpm.log"
        echo "daemonize = no"
        echo "include=/usr/local/etc/php-fpm.d/*.conf"
    } | tee "$filePath"

    makeDirectory "$base/php-fpm.d"

    filePath="$base/php-fpm.d/www.conf"
    {
        echo "[www]"
        echo "user = nobody"
        echo "group = nobody"
        echo "listen = [::]:9000"
        echo "pm = dynamic"
        echo "pm.max_children = 5"
        echo "pm.start_servers = 2"
        echo "pm.min_spare_servers = 1"
        echo "pm.max_spare_servers = 3"
    } | tee "$filePath"
}

ini
fpm