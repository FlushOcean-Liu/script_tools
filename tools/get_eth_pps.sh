#!/bin/bash

sleep_time="1"

if [ -z "$1" ]; then
    echo
    echo usage: $0 [network-interface]
    echo
    echo e.g. $0 eth0
    echo
    echo show eth device pps
    exit
fi

dev=$1

while true
do
    rx_start=`cat /sys/class/net/$dev/statistics/rx_packets`
    tx_start=`cat /sys/class/net/$dev/statistics/tx_packets`

    sleep $sleep_time

    rx_end=`cat /sys/class/net/$dev/statistics/rx_packets`
    tx_end=`cat /sys/class/net/$dev/statistics/tx_packets`

    rx_pps=`expr $rx_end - $rx_start`
    tx_pps=`expr $tx_end - $tx_start`

    echo "tx $dev: $tx_pps pkts/s -- rx $dev: $rx_pps pkts/s"
done

