#!/bin/sh

if [ ! -n "$1" ];then
    echo "./serial_file [dir]"
    exit
fi

pcap_dir=$1
for file in `ls $pcap_dir`
do
    number=${file##*pcap}
   
    str_new=$(echo -e $number|sed -r 's/0*([0-9])/\1/')

    common=${file%%pcap*}

    trans_num=$(printf "%03d" $str_new)

    echo mv $pcap_dir/$file $pcap_dir/$common"pcap"$trans_num
    mv $pcap_dir/$file $pcap_dir/$common"pcap"$trans_num
done
