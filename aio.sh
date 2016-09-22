#!/bin/bash
#Displays: Interface Name, Adapter Branding String, Driver Name/Version, Firmware Version, Bus Location, IPv4 Address and IPv6 Address


ip link | awk '/mtu/ {gsub(/:/,"");print$2}' | sort | while read -r i; do 
printf "\n$i\n"; b=$(ethtool -i $i 2> /dev/null | awk 'NR>=1 && NR<=4' )
echo "$b" | awk 'NR==4 {print $2}' | xargs lspci -s 2>/dev/null | cut -d' ' -f 4-
echo "$b";  ip addr show dev $i |  awk '/inet/ {print $2}'; done
