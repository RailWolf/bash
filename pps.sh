#!/bin/bash
pps () {
ethtool -S eth1 | grep rx_packet | awk 'NR==1 {print $2}'
}
count_old=$(pps)
while :; do
sleep 1
count_new=$(pps)
packets_per_second=$(($count_new - $count_old))
echo $packets_per_second
count_old=$count_new
done
