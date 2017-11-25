# 基础镜像为centos
FROM centos

# 创建、维护人员  magein
MAINTAINER magein

# 设置安装版本
ENV NGINX_VERSION=nginx-1.12.2

# nginx安装路径
ENV NGINX_PREFIX=/usr/local/nginx

# 安装依赖 gcc、wget、make、zlib、pcre
RUN yum -y install gcc wget make pcre-devel.x86_64 zlib-devel.x86_64  > /dev/null

# 官网下载nginx
RUN wget  http://nginx.org/download/$NGINX_VERSION.tar.gz

# 解压nginx包
RUN tar -xzf $NGINX_VERSION.tar.gz

# 编译、安装 nginx
RUN cd $NGINX_VERSION && ./configure --prefix=$NGINX_PREFIX > /dev/null && make > /dev/null &&make install > /dev/null

# 删除文件nginx包以及文件
RUN rm -rf $NGINX_VERSION*

# 主机中的nginx文件
ENV HOST_HOME=/usr/local/nginx

# 使用主机中的配置文件
ADD $HOST_HOME/conf $NGINX_PREFIX/conf

# 使用主机中的日志文件
ADD $HOST_HOME/logs $NGINX_PREFIX/logs

# 使用主机中的html项目路径
ADD $HOST_HOME/html $NGINX_PREFIX/html

# 使用主机中的var
ADD /var/ /var/

# 暴露80端口
EXPOSE 80

# 启动nginx
ENTRYPOINT /usr/local/nginx/sbin/nginx -g "daemon off;"
