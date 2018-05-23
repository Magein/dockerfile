#!/usr/bin/env bash

if [ $1 ]; then
    directory=$1
else
    directory="./"
fi

if [ ! -d "$directory" ]; then
    mkdir -p "$directory"
fi

filePath="$directory/nginx.conf"

if [ ! -f "$filePath" ]; then
    touch "$filePath"
fi

{
    echo "worker_processes  1;"
    echo "events{
        worker_connections  1024;
    }"
    echo "http{

        include       mime.types;

        default_type  application/octet-stream;

        sendfile        on;

        keepalive_timeout  65;

        server{

            listen       80;

            server_name  localhost;

            root   /var/www;

            location /
            {
                index  index.html;
            }

            error_page  404             /404.html;
            location = /404.html
            {
                root   /var/www;
            }

            error_page   500 502 503 504  /50x.html;
            location = /50x.html
            {
                root   /var/www;
            }

            location ~ \.php$
            {
                fastcgi_pass   127.0.0.1:9000;
                fastcgi_index  index.php;
                fastcgi_param  SCRIPT_NAME      /scripts\$fastcgi_script_name;
                include        fastcgi_params;
            }
        }
    }"

} | tee "$filePath"