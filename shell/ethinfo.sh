#!/bin/bash
# list eth dev info although some eth was bound dpdk driver.

# get eth dev info from lspci and format the output 
# as shell script's value assignment.
eth_info=$(lspci -Dvmmnnk | awk -v RS="\n\n" '/Eth/{print gensub(/:\s([^\n]*)/, cnt++ "=\"\\1\"", "g");} END{print "dev_cnt=" cnt;}')

# eval the shell script to get the variables.
eval $eth_info

# eth tbl header
printf "%-14s%-15s%-3s%-7s %s\n" "Slot" "IF" "UP" "Driver" "Desc"


if [ ! -n "$dev_cnt" ];then    #判断参数1是为空，为空则提示参数1不能为空，并退出
    echo "dev_cnt is null"
    exit
fi

for ((i=0; i<$dev_cnt; i++))
do
 # calculate eth interface and linking status
 # if eth1's Slog is 0000:05:00.0
 # it's interface name is /sys/bus/pci/devices/0000:05:00.0/net/[interface]
 # it's linking status in /sys/bus/pci/devices/0000:05:00.0/net/[interface]/carrier
 eval "Interface$i=---"
 eval "Linking$i=-"
 eval "dev_net_path=/sys/bus/pci/devices/\$Slot$i/net"
 if [ -e $dev_net_path ]
 then
    eval "Interface$i=$(ls $dev_net_path)"
    eval "read Linking$i</sys/bus/pci/devices/\$Slot$i/net/\$Interface$i/carrier"
 fi
 eval "printf '%-14s%-15s%-3s%-7s %s\n' \$Slot$i \$Interface$i \$Linking$i \$Driver$i \"\$Device$i\""
done
