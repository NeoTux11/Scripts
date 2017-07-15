#!/bin/bash

# This script created by NeoTux allows connection unlimited 
# to network available only for a certain duration (like 10 minutes)
# Usage : ./wifi_unlimited.sh <interface> <uuid> <duration>
# Note : This script use macchanger and you need possibly use nmcli to discover UUIDs

# Check arguments
if [[ -z $1 || -z $2 || -z $3 ]]; then
    echo -e 'Usage : ./wifi_unlimited.sh <interface> <uuid> <duration>'
    echo -e 'Show UUIDs with "nmcli c show"'
    exit 1
fi

# Store variables
interface=$1
uuid=$2
duration=$3

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

# Livebox-AAB6 : 8102b85e-df9b-43e9-8af3-7f73e07b0982
