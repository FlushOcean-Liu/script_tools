#!/bin/bash



# 将test.txt数据读入变量result中
result=`cat ./test.txt`

# 将result中 等号两边的空格去掉
result=`echo "$result" | sed 's/[[:space:]]*=[[:space:]]*/=/g'`

# 将result中 含有 “[” 关键词所在行替换为空
result=`echo "$result" | sed 's/.*\[.*//'`

# 曾result中数据作为shell脚本变量
# eval 命令会对变量进行两次扫描，
#      第一次扫描获取变量名字，本次第一次扫描获取result内容
#      第二层扫描应用变量，本次执行result，对test.txt 有等号变量赋值
eval "$result"

# 打印cmd_line 变量值，此处就可以直接使用变量名调用test.txt 中的配置了
echo "$cmd_line"
