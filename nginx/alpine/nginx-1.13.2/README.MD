### version

    nginx-1.13.2

### gpg 验证

    从秘钥服务器导入秘钥，这里只用了一个秘钥服务器，可修改成多个确保正确导入
    
### 问题

    1. pcre-dev 这个不能删除，启动nginx需要  libpcre.so支持
    