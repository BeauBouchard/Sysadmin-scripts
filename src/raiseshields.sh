#!/bin/bash
# A small script to load a list of IPs into iptables

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
