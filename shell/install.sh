#!/bin/sh

# 显示帮助信息
usage(){
    echo "Usage:"
    echo "  install [options]"
    echo "  install -o --version 17.09.0.ce-1.el7.centos"
    echo "Options:"
    echo "  -c, --check              Check install environment"
    echo "  -h, --help               Show information for help"
    echo "  -r, --remove             If already installed,then remove"
    echo "  -s, --show               Display the docker version of the optional installation"
    echo "  -v, --version            The version of the docker to install"
}

# 显示可选的docker版本
show(){
    result=$(yum list docker-ce --showduplicates | sort -r | grep docker-ce)
    if [ ! $1 ]; then
        echo -e "$result"
    fi
}

# 检测系统环境
check(){
    result=1
    # 检测是否为centOS系统
    cat /etc/redhat-release | grep CentOS > /dev/null
    if [ $? -eq 1 ]; then
        result=0
        echo "Not the CentOS system"
    fi

    # 检测内核版本
    kernel=$(uname -r | awk -F. '{print $1}')
    if [ "$kernel" -lt 3 ]; then
        result=0
        echo $(uname -r)
        echo "The kernel version needs more than 3"
    fi

    if [ "$result" -eq 1 ]; then
        echo "Check pass"
        return 0
    fi

    return 1
}

# 安装docker
install(){
    # 删除docker相关信息
    sudo yum remove -y docker \
                    docker-client \
                    docker-client-latest \
                    docker-common \
                    docker-latest \
                    docker-latest-logrotate \
                    docker-logrotate \
                    docker-selinux \
                    docker-engine-selinux \
                    docker-engine

    # 安装所需的包
    sudo yum install -y yum-utils \
                    device-mapper-persistent-data \
                    lvm2

    # 设置稳定的存储库
    sudo yum-config-manager \
                    --add-repo \
                    https://download.docker.com/linux/centos/docker-ce.repo

    yum -y install docker-ce-"$1"
}

# 倒计时
countDown(){
    total=10
    if [ $1 ]; then
        total=$1
    fi
    i=0
    while [ "$i" -lt "$total" ];
    do
        echo -n "wait `expr $total - $i`s"
        sleep 1
        echo -ne "\r        \r"
        ((i++))
    done
}

options=$(getopt -o chsrv:y --long check,help,remove,show,version: -n "error" -- "$@")

eval set -- "$options"

remove=0
goon=0

while true
do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -s|--show)
            show
            exit 0
            ;;
        -c|--check)
            check
            exit 0
            ;;
        -r|--remove)
            remove=1
            shift 1
            ;;
        -y)
            goon=1
            shift 1
            ;;
        -v|--version)
            version=$2
            shift 2
            ;;
        *)
        break
        ;;
    esac
done

# 是否已经安装docker
which docker > /dev/null
if [ $? -eq 0 -a "$remove" -eq 0 ]; then
    echo "Docker already install"
    echo $(docker --version)
    echo "You can use '-r' or '--remove' to force the delete"
    exit 0
fi

# 如果选择了版本则验证版本是否正确
show 1
if [ "$version" ]; then
    echo -e "$result" | awk '{print $2}' | grep -E "^$version\$"
    if [ $? -eq 1 ]; then
        echo "Docker version error"
        echo "You can get help information by useing -h or --help"
        echo "Version list:"
        echo -e "$result" | sed  's/docker/     docker/'
        exit 1
    fi
fi

# 获取最新的docker版本，并且提示即将安装此最新版本
version=`echo "$result" | awk 'NR==1{print $2}'`
if [ "$goon" -eq 0 ]; then
    read -p "You will install version $version,entry y will continue: " -n 1 keep
    if [ "$keep" != "y" ]; then
        exit 1
    fi
else
    echo "I will install version $version for you"
fi

countDown 5

install "$version"