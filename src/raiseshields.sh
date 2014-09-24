#!/bin/bash
# A small script to load a list of IPs into iptables
# 


IPS_TO_BLOCK=`cat /etc/iptablesv4.list`
IPTABLES=`/sbin/iptables`
CURRENT_RULES=`iptables -L`
IPTABLES=`whereis iptables | awk '{print $2}'`

for ENTRIES in IPS_TO_BLOCK; 
	do
	SUCCESS=0
	grep "$ENTRIES" "$CURRENT_RULES"
		if [ ! "$?" = "$SUCCESS" ]; 
			then 
			$IPTABLES -I INPUT -i eth0 -s $ENTRIES -j DROP
			$IPTABLES -I OUTPUT -o eth0 -d $ENTRIES -j DROP
		fi
done
