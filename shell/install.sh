#!/bin/sh

# 检测是否为centOS系统
cat /etc/redhat-release > /dev/null
if [ $? -eq 1 ]; then
    echo "Not the CentOS system"
    exit 1
fi

# 检测内核版本
kernel=$(uname -r | awk -F. '{print $1}')
if [ "$kernel" -lt 3 ]; then
    echo $(uname -r)
    echo "The kernel version needs more than 3"
    exit 1
fi

# 是否已经安装docker
which docker > /dev/null
if [ $? -eq 0 ]; then
    echo "docker already install"
    echo $(docker --version)
    read -p "enter n will exit,otherwise it will continue" -n 1 keep
    if [ "$keep" = "n" ]; then
        exit 0
    fi
fi

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

# 显示可以安装的docker版本
yum list docker-ce --showduplicates | sort -r

# 选择版本 不选则安装最新的版本
read -p "Please select the docker version:" version

if [ -n "$version" ]; then
    sudo yum -y install docker-ce-"$version"
else
    sudo yum -y install docker-ce
fi

