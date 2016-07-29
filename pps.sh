#!/bin/bash
pps () {
ethtool -S eth1 | grep rx_packet | awk 'NR==1 {print $2}'
}
count_old=$(pps)
while :; do
sleep 1
count_new=$(pps)
echo $(($count_new - $count_old))
count_old=$count_new
done
