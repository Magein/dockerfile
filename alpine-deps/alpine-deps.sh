#!/bin/sh
Usage(){
    echo "Usage:"
    echo "  manager dependent, create or delete,default create"
    echo "  alpine-deps [options]"
    echo "  alpine-deps -d base"
    echo "  alpine-deps -d build"
    echo "  alpine-deps -d base -d build"
    echo "Options:"
    echo "  -d,--delete             delete dependents"
    echo "  -h,--help               show information for help"
}

options=$(getopt -o d:h --long delete:,help -n "error" -- "$@")

if [ $? -ne 0 ]; then
   exit 0
fi

eval set -- "${options}"

delete=()

while true;
do
    case $1 in
        -d|--delete)
            length="${#delete}"
            delete[$length]="."$2"-deps"
            shift 2
        ;;
        -h|--help)
            Usage
            exit 0
        ;;
        *)
            break
        ;;
    esac
done

if [ "$delete" ]; then
    for i in "${delete[@]}";
    do
        apk del "$i"
    done
else
    # 安装依赖需要的基础的文件，这里确认不用的时候，可调用删除
    apk add --no-cache --virtual .build-deps \
        autoconf \
        g++ \
        gcc \
        make

    # 效验压缩包、下载、编译用到的工具，服务安装完成后即可删除
    apk add --no-cache --virtual .base-deps \
        dpkg-dev \
        dpkg \
        file \
        libc-dev \
        pkgconf \
        re2c \
        gnupg \
        wget
fi