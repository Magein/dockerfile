### 配置
    
    1. fastcgi方式启动的时候，需要把php-fpm.conf的listen 配置成 [::]:9000
        即：
            listen=[::]:9000
            
       附：php7之后的版本php-fpm管理器配置和应用池配置分开了，应用池配置在php-fpm.conf同级目录下的php-fpm.d目录下
            
    2.输出php错误信息（开发调试）
        
        php.ini配置中的display_errors 设置为 on
        