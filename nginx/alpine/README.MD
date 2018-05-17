### 文件说明

    nginx-1.13.2-explain    测试文件格式
     
    nginx-1.13.2            构建nginx文件            
    
### version

    nginx-1.13.2

### gpg 验证
    
     gpg_key B0F4253373F8F6F510D42178520A9993A1C052F8
     
     如何找到key：
     
     1. 下载nginx包（nginx-1.13.12.tar.gz）和数字签名包（nginx-1.13.12.tar.gz.asc ）
     
     2.  直接验证 gpg --verify nginx-1.13.12.tar.gz.asc nginx-1.13.12.tar.gz
        
        出现错误：
            gpg: 于 2018年04月10日 星期二 22时13分01秒 CST 创建的签名，使用 RSA，钥匙号 A1C052F8
            gpg: 无法检查签名：No public key
         
        从错误文件中可以看到钥匙号：A1C052F8
         
        echo $? 得到非0值(得到130)，使用set -xe 会退出，检测通过则$?为0值
      
     3. 导入服务器导入公钥
     
        export GNUPGHOME=$(mktemp -d)
         
        gpg --keyserver keyserver.ubuntu.com --recv-keys A1C052F8
     
     4. 查看指纹和和秘钥信息
     
        gpg --fingerprint
         
        pub   2048R/A1C052F8 2014-06-16 [已吊销：2016-08-16]
        密钥指纹 = 950A AD15 BA59 3EE2 5B41  F1B5 5F5E A984 A1C0 52F8
        uid                  Maxim Dounin <mdounin@mdounin.ru>
        
        pub   2048R/A1C052F8 2011-11-27
        密钥指纹 = B0F4 2533 73F8 F6F5 10D4  2178 520A 9993 A1C0 52F8
        uid                  Maxim Dounin <mdounin@mdounin.ru>
        sub   2048R/D345AB09 2011-11-27
        
        获得秘钥指纹 B0F4 2533 73F8 F6F5 10D4  2178 520A 9993 A1C0 52F8
     
     