# 基础镜像为centos
FROM centos

# 创建、维护人员  magein
MAINTAINER magein

# 安装依赖 gcc、wget、make、zlib、pcre
RUN yum -y install gcc wget make pcre-devel.x86_64 zlib-devel.x86_64  > /dev/null

# 下载nginx压缩包到指定位置
RUN wget  http://nginx.org/download/nginx-1.12.2.tar.gz

# 解压nginx包
RUN tar -xzf nginx-1.12.2.tar.gz

# 编译、安装 nginx
RUN cd nginx-1.12.2 && ./configure --prefix=/usr/local/nginx > /dev/null && make > /dev/null &&make install > /dev/null

# 删除文件nginx包以及文件
RUN rm -rf nginx-1.12.2*

# 暴露80端口
EXPOSE 80

# 设置环境变量（测试代码）
ENV COMMAND=ls
ENV PARAM=/

# 执行指令 环境变量 和cmd测试使用 可以删除 使用["$COMMAND","$PARAM"]报错（测试代码）
CMD $COMMAND $PARAM

# 启动nginx
ENTRYPOINT /usr/local/nginx/sbin/nginx -g "daemon off;"