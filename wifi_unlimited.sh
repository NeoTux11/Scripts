#!/bin/bash

# This script created by NeoTux allows connection unlimited 
# to network available only for a certain duration (like 10 minutes)
# Usage : ./wifi_unlimited.sh <interface> <duration>
# Note : This script needs macchanger

# Check arguments
if [[ -z $1 || -z $2 ]]; then
    echo -e 'Usage : ./wifi_unlimited.sh <interface> <duration>'
    exit 1
fi

# Store variables
interface=$1
duration=$2
current_mac=$(cat /sys/class/net/$interface/address)

# Print current MAC Adress
echo -e "[*] Your current MAC Adress is $current_mac
and it will be changed every $duration seconds \n"

# Main loop deco/reco
while true; do
    
    # Change MAC Adress
    ifconfig $interface down
    macchanger -r $interface > /dev/null
    ifconfig $interface up
    service networking restart
    service network-manager restart
    
    # Print new MAC on terminal
    time=$(date +%H:%M:%S)
    mac=$(cat /sys/class/net/$interface/address)
    echo -e "[$time] - New MAC Adress - $mac"
    sleep $duration

done
