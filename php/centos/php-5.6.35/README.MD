### 配置
    
    1. fastcgi方式启动的时候，需要把php-fpm.conf的listen 配置成 [::]:9000
        即：
            listen=[::]:9000
            
    2.输出php错误信息（开发调试）
        
        php.ini配置中的display_errors 设置为 on
        
    3. 5.6的php-fpm配置文件和pool的配置是在一起的，但是可以使用include包含，所以5.6的可以把配置文件分离，风格修改为跟7.x系列一直
        
    
    
    