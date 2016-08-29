#!/bin/bash
#Monitor RX Packets Per Second of the specified interface
#2016 Brandon Calhoun

pps () {
ethtool -S eth1 | awk '/rx_packet {NR==1; print $2}'
}
count_old=$(pps)
while :; do
sleep 1
count_new=$(pps)
echo $(($count_new - $count_old))
count_old=$count_new
done
