# 加载基于alpine系统的所需依赖
FROM registry.cn-hangzhou.aliyuncs.com/magein/alpine-deps:latest

# php支持扩展需要的依赖，不能删除
RUN apk add --no-cache --virtual .build-deps \
         libxml2-dev \
         curl-dev \
         openssl-dev \
         gd-dev \
         jpeg-dev \
         libpng-dev \
         freetype-dev