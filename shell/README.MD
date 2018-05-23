### 脚本说明

    common.sh  创建目录 文件 以及下载镜像函数
    config.sh  创建php.ini、php-fpm.conf、nginx.conf、www.conf配置文件，都是简写的配置文件
    start.sh   快速启动nginx+php容器
    
    下载后，如果在win下面编辑请使用dos2unix进行文件转化
    如：
        ls | xargs dos2unix
        
        ./start.sh