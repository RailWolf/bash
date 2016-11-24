#!/usr/bin/bash

tmp=$(mktemp)
IFS=

eval dialog --menu \"Choose the Shelf or Rack:\" 50 50 50 $(awk '/Rack/ || /Shelf/' db.txt | sed -r 's/^/"/;s/$/" " "/' | tr $'\n' ' ') 2>$tmp
loc=$(tr -d '' < $tmp | sed 's/^[ \t]*//' | cut -d' ' -f2)

eval dialog --menu \"Choose a switch \in $loc\:\" 50 50 50 $(awk '/'$loc'/ && /Switch/' db.txt | cut -f1 -d';' | sed -r 's/^/"/;s/$/" " "/' | tr $'\n' ' ') 2>$tmp
 switch=$( grep $(tr -d '' < $tmp | sed 's/^[ \t]*//;s/.*://' ) db.txt | cut -f3 -d";")

dialog --title "Port" --inputbox "Enter the port number" 8 50 2>$tmp
port=$(<$tmp)

dialog --title "VLAN" --inputbox "Enter the VLAN ID" 8 50 2>$tmp
vlan=$(<$tmp)

expect scripts/$switch.sh $port $vlan

printf "\n<- DONE ->\n"