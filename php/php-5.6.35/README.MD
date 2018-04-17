### 配置
    
    1. fastcgi方式启动的时候，需要把php-fpm.conf的listen 配置成 [::]:9000
        即：
            listen=[::]:9000
            
    2.输出php错误信息（开发调试）
        
        php.ini配置中的display_errors 设置为 on
        
    
    
    