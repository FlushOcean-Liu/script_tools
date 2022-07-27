#!/bin/bash

# 遍历指定目录的文件

if [ ! -n "$1" ];then
    echo "dir is NULL!"
    echo "usage example:./traverse_file.sh /home/test"
    exit -1
fi


traverse_dir()
{
    local dir=$1
    echo $dir
    if [ ! -n "$dir" ];then
        echo "dir is NULL，function need a argument"
        exit -1
    fi

    for file in `ls $dir`
    do
        dir_file=$dir"/"$file
	if [ -d "$dir_file" ];then       # 是目录
            echo "####[$dir_file] is dir "
            traverse_dir $dir_file
	elif [ -f $dir_file ];then       # 是文件
            echo "$dir_file"
	fi
    done
}

traverse_dir $1
