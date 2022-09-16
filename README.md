# script_tools
记录工作学习中常用的脚本小工具。


## 1.查看每个文件每一行，指定分隔符，打印分割后指定索引位置的字符串

```bash
cat test.txt | awk -F" " '{print $2}'
```

## 2.合并两个文件相同的行，指定合并分割符号
```bash
# -d 表示两行合并中间的连接符号，可以为空
paste -d "-" a.txt b.txt 
```

## 3.rename批量修改文件名
有两个版本c语言版本和perf版本，centos一般是c版本，ubuntu是perf版本

把当面目录下所有后缀 .bak 的文件，把.bak全部去掉
```bash
#c版
rename .bak "" *.bak

#perf版
rename 's/\.bak$//'  *.bak
```


## 4.大小写转换
```bash
str_lower='a-z'
str_upper='A-Z'

str_test="hello"

lo=`echo $str_test | tr $str_upper $str_lower`
up=`echo $str_test | tr $str_lower $str_upper`

# 把test变量中所有小写字母转为大写
$ echo ${test^^}

# 把变量中的所有大写字母，全部替换为小写
$ echo ${test,,}


```
