#!/bin/bash
# A small script to load a list of IPs into iptables
# assumes that the IP addresses you wish to block are put in file /etc/iptablesv4.list
# will add input arg later, also regex for comments on same line as address
# this file can contain comments starting with ; or #
# but these must not be included on the end of IP addresses
# #comment allowed
# ;comment allowed
# 192.168.1.2 ;NOT ALLOWED
# 192.168.1.2 #NOT ALLOWED
# firewall blocks can be single IP, CIDR, or a RANGE
# 192.168.1.1
# 192.168.1.0/24
# 192.168.1.1-192.168.1.10

IPS_TO_BLOCK=/etc/iptablesv4.list

#checks to see if iptables list exists
if [ ! -f $IPS_TO_BLOCK ]
        then
                echo "Unable to add blocks to IPTABLES because file $IPS_TO_BLOCK is missing"
                exit
        fi

CURRENT_RULES=`iptables -nL`

while read entries ;do

        # skip comment lines starting with ; or #
        case $entries in
                \#*|\;*)
                continue
                ;;
        esac

        if [[ $CURRENT_RULES =~ $entries ]]
        then
                printf "%-20s %20s\n" $entries 'already referenced in iptable - skipping'
                else
                # is this CIDR, range or single IP?
                        if [[ $entries =~ "-" ]]
	                then
	                        
	                        #--src-range
	                        printf "%-20s %20s %1s %1s\n" 'ADDING RULE:' 'iptables -A INPUT --src-range' $entries '-j DROP'
	                        iptables -A INPUT --src-range $entries -j DROP
	                else
	                        
	                        #--CIDR or single
	                        printf "%-20s %20s %1s %1s\n" 'ADDING RULE:' 'iptables -A INPUT -s' $entries '-j DROP'
	                        iptables -A INPUT -s $entries -j DROP
                        fi
                fi
done < $IPS_TO_BLOCK
