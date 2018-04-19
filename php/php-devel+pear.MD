### 关于pear和pecl

    pear，全称 PHP Extension and Application Repository，是PHP扩展和应用仓库
     
    将php中常用的功能封装为类库，避免了重复造‘轮子’。用户可以直接下载集成在自己的php代码中使用。功能跟composer一样。
     
    pecl，全称 PHP Extension Community Library PHP ，pecl是用C语言编写的php底层扩展，用来解决php难以解决的问题。用户下载后需要编译配置才可以使用。
     
    pear 和 pecl 都是为了给用户提供现成的特定功能的函数或类，只是pear是纯php语言编写，是php的上层扩展，pecl是C语言编写，是php的底层扩展。
     
    附：
        phar(PHP Archive php归档文件)
         
        phar类似java中的jar包，是一种压缩包。可以对php项目进行打包成 .phar类型的文件，也可以把某个功能模块打包直接发布
        
        
### 安装pear和pecl

    如果是源码包安装的php，pear 和 pecl 在php安装目录的bin目录下，可以直接使用
     
    也可以独立安装pear，pecl不需要安装，只要安装pear即可使用pecl
     
    安装pear需要用到php解释器，所以需要安装php开发包，通过rpm安装php-devel有很多依赖需要安装，
     
    rpm包查找网址：http://rpm.pbone.net 或者 https://pkgs.org/
     
    可以根据需求安装对应的开发包，安装 php7的开发包:
          
        php71w-devel-7.1.13-1.w6.x86_64.rpm
        依赖：php71w-cli-7.1.13-1.w6.x86_64.rpm
        依赖：php71w-common-7.1.13-1.w6.x86_64.rpm
        依赖：libgmp.so.3() 
        .....
        在安装 php71w-common-7.1.13-1.w6.x86_64.rpm 的时候即可选择使用 --nodeps 跳过检查依赖
        
    安装pear:
        参考：http://pear.php.net/manual/en/installation.getting.php
        
    pecl 使用报错：
        参考：https://serverfault.com/questions/589877/pecl-command-produces-long-list-of-errors
        
        需要修改 pecl的shell脚本，在最后一行把 -n 去掉

    