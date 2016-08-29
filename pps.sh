#!/bin/bash
#Monitor RX Packets Per Second
#Set IFACE to the name of the interface to monitor
#2016 Brandon Calhoun

IFACE=eth1
pps () {
ethtool -S $IFACE| awk '/rx_packet/{NR==1;print $2}'
}
count_old=$(pps)
while :; do
sleep 1
count_new=$(pps)
echo $(($count_new - $count_old))
count_old=$count_new
done
