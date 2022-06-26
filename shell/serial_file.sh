#!/bin/sh

if [ ! -n "$1" ];then    #判断参数1是为空，为空则提示参数1不能为空，并退出
    echo "./serial_file [dir]"
    exit
fi

pcap_dir=$1
for file in `ls $pcap_dir`
do
    number=${file##*pcap}    # 取pcap关键词后面的字符串
   
    str_new=$(echo -e $number|sed -r 's/0*([0-9])/\1/')  # 取数字

    common=${file%%pcap*}    # 取pcap关键词前面的字符串

    trans_num=$(printf "%03d" $str_new)  # 将数字格式化为统一的位数，不足前面补0

    echo mv $pcap_dir/$file $pcap_dir/$common"pcap"$trans_num
    mv $pcap_dir/$file $pcap_dir/$common"pcap"$trans_num
done
