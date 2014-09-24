#!/bin/bash
#A small script to load a list of IPs into iptables

IPS_TO_BLOCK="/etc/iptablesv4.list"
IPTABLES="/sbin/iptables"
if [ -f $IPS_TO_BLOCK ]; then
	while read BLOCKED; do
		$IPTABLES -A INPUT -i eth0 -s $BLOCKED -j DROP
		$IPTABLES -A OUTPUT -o eth0 -d $BLOCKED -j DROP
	done < $IPS_TO_BLOCK
fi
