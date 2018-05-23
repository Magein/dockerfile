#!/bin/sh
makeDirectory(){
    for dir in "$@";
        do
            if [ ! -d "$dir" ];then
                mkdir -p "$dir"
            fi
    done
}

makeFile(){
     for name in "$@";
        do
            if [ ! -f "$name" ];then
                touch "$name"
            fi
    done
}

registry(){
    for registry in "$@";
        do
        docker images | grep -w "$registry" > /dev/null
        if [ $? -eq 1 ]; then
            docker pull "$registry"
        fi
    done
}