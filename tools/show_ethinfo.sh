#! /bin/bash

# 脚本功能：
# 列出所有网卡信息，包括被dpdk绑定的网卡


# get eth dev info from lspci and format the output 
# as shell script's value assignment.
dev_info=$(lspci -Dvmmnnk | awk -v RS="\n\n" '/Eth/{print gensub(/:\s([^\n]*)/, cnt++ "=\"\\1\"", "g");} END{print "dev_cnt=" cnt;}')

# eval the shell script to get the variables.
eval $dev_info

# eth tbl header
printf "%-14s%-15s%-3s%-7s %s\n" "Slot" "IF" "UP" "Driver" "Desc"

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
