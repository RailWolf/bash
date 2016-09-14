#!/bin/bash
#Monitor dropped packet count of the specified interface, updating every 1 second
#Displays total dropped packets, dropped packets per second, total received packets, and received packets per second
IFACE=ens1f1

rx_packet_data () {
ethtool -S $IFACE | grep $1 | awk 'NR==1 {print $2}'
}

RED='\033[0;31m'
NC='\033[0m'
rx_packet_total_old=$(rx_packet_data rx_packet)
rx_dropped_old=$(rx_packet_data rx_dropped)

while :; do
 sleep 1
 rx_packet_total_new=$(rx_packet_data rx_packet)
 rx_dropped_new=$(rx_packet_data rx_dropped)
 echo "Dropped packets total"
 rx_packet_data rx_dropped | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
 echo -e "${RED}Dropped packets per second${NC}"
 echo -e "${RED}$((rx_dropped_new - rx_dropped_old)) ${NC}" | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
 echo "rx_packets total"
 rx_packet_data rx_packet | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
 echo "rx_packets per second"
 echo $((rx_packet_total_new - rx_packet_total_old)) | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
 rx_dropped_old=$rx_dropped_new
 rx_packet_total_old=$rx_packet_total_new
 printf "\n\n\n"
done
