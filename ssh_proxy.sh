#!/bin/bash

SOCKS_PROXY='socks-gw.reith.bbc.co.uk:1085'
LOCAL_IP_RANGES='10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 127.0.0.0/8'

if [[ $# != 2 ]]; then
  echo "Usage: $0 [hostname] [port]"
  exit 1
fi

host=$1
port=$2

lookup=$(host $1)

if [[ $lookup =~ "not found" ]]; then
  echo "Host not found"
  exit 1
fi

ip=$(echo $lookup | cut -d ' ' -f 4)

is_local=$(ruby -e "require 'ipaddr'; print %w{$LOCAL_IP_RANGES}.any? {|range| IPAddr.new(range).include? '$ip'}")

networklocation=$(networksetup -getcurrentlocation)

if [[ "$is_local" = "false" ]] && [[ "$networklocation" = "BBC On Network" ]]; then
  nc -x $SOCKS_PROXY -X 5 $host $port
else
  nc $host $port
fi
