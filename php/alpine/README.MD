### 介绍
    
    date/dockerfile 是alpine修改时区的方式，默认的是utc 北京时间是东八区，统一时间用的
     
    alpine中web用户标准的uid，gid是82，可查阅以下文档
    
    1. http://git.alpinelinux.org/cgit/aports/tree/main/apache2/apache2.pre-install?h=v3.3.2
    2. http://git.alpinelinux.org/cgit/aports/tree/main/lighttpd/lighttpd.pre-install?h=v3.3.2
    3. http://git.alpinelinux.org/cgit/aports/tree/main/nginx-initscripts/nginx-initscripts.pre-install?h=v3.3.2
      
    php-fpm的应用池用的 user  group 配置是针对 目录以及文件权限的，以什么用户身份访问php文件，默认的 nobody 是linux中的其他人身份访问，所以php文件需要有其他人的访问权限
     
    1. docker应用中，如果配置文件是宿主机映射进去的，配置文件中的用户需要在容器中存在
     
    2. docker应用中，如果web目录是映射进去的，需要在主机中添加容器中指定的用户，以及用户所在组，然后把web目录赋予用户可访问
    
     
    容器中的用户和组配置：
        $ addgroup -g 82 -S www-data 
        $ adduser -u 82 -D -S -G www-data www-data
        
    主机中的web目录: /var/www
    
        $ groupadd -g -r 82 www-data
        $ useradd -M -g 82 -s /sbin/nologin www-data
        $ chgrp www-data /var/www
        $ chmod 750 /var/www
        
    这样设置可以保护 /var/www 不会被任意访问，修改，只允许组内成员访问，
    在宿主机中配置对应的权限，特别注意，宿主机中操作用户的权限时，
    容器和主机中的用户应该一一对应 uid、gid要保持相同
    
    