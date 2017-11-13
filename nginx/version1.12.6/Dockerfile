# 基础镜像为centos
FROM docker.io/centos

# 创建、维护人员  magein
MAINTAINER magein

# 设置安装版本
ENV NGINX_VERSION=nginx-1.12.2

# 安装依赖 gcc、wget、make、zlib、pcre
RUN yum -y install gcc wget make pcre-devel.x86_64 zlib-devel.x86_64  > /dev/null

# 官网下载nginx
RUN wget  http://nginx.org/download/$NGINX_VERSION.tar.gz

# 解压nginx包
RUN tar -xzf $NGINX_VERSION.tar.gz

# 编译、安装 nginx
RUN cd $NGINX_VERSION && ./configure --prefix=/usr/local/nginx > /dev/null && make > /dev/null &&make install > /dev/null

# 删除文件nginx包以及文件
RUN rm -rf $NGINX_VERSION*

# 暴露80端口
EXPOSE 80
