#!/usr/bin/env bash


tmp=$(mktemp)
IFS=

eval dialog --menu \"Choose the Shelf or Rack:\" 50 50 50 $(grep "Shelf\|Rack" rackshelf.txt | sed -r 's/^/"/;s/$/" " "/' | tr $'\n' ' ') 2>$tmp
loc=$(tr -d '' < $tmp | sed 's/^[ \t]*//' | cut -d' ' -f2)
#echo $loc

eval dialog --menu \"Choose a switch \in $loc\:\" 50 50 50 $(awk '/'$loc'/ && /Switch/' rackshelf.txt | cut -f1 -d';' | sed -r 's/^/"/;s/$/" " "/' | tr $'\n' ' ') 2>$tmp
 switch=$( grep $(tr -d '' < $tmp | sed 's/^[ \t]*//;s/.*://' ) rackshelf.txt | cut -f3 -d";")
 echo $switch

dialog --title "Port" --inputbox "Enter the port number" 8 50 2>$tmp
response=$?
port=$(<$tmp)
#echo $port

dialog --title "VLAN" --inputbox "Enter the VLAN ID" 8 50 2>$tmp
response=$?
vlan=$(<$tmp)
echo $vlan

expect scripts/$switch.sh $port $vlan

printf "\n<- DONE ->\n"
