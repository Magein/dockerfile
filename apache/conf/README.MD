### apache的相关配置文件

    这里是apache2.4的相关配置文件，启动docker的时候建议使用挂载的方式
     
    使用挂载的话，就可以根据自己的需求进行一些配置 
     
    如：需要支持php 需要在配置文件中增加 libphp7模块
    
        LoadModule php7_module        modules/libphp7.so
        
        需要支持php文件：在<IfModule mime_module>下增加：
         
        AddType application/x-httpd-php .php