#!/bin/bash
login () {
ssh $1@$2 $3
}

read -p "Select option centos(1) or debian(2): " option
echo "Enter \"password\" when prompted"
case "$option" in
1)
login railwolf 192.168.1.3 'cat test' ;;
2) 
login root 192.168.1.4 'cat test_file' ;;
*)
echo "invalid"

esac
