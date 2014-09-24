I made a couple of scripts for doing some simple sysadmin tasks.


## raiseshields.sh

 Filename: raiseshields.sh
 
 Author: [@BeauBouchard](http://www.twitter.com/beaubouchard)
 
 **Description:**
 
A small script to load a list of IPs into iptables, assumes that the IP addresses you wish to block are put in file /etc/iptablesv4.list. 

Features for future: 
will add input arg later, also regex for comments on same line as address. This file can contain comments starting with ; or #
 * #comment allowed
 * ;comment allowed
however you can not comment after the IP listing in this version
 * 192.168.1.2 ;NOT ALLOWED
 * 192.168.1.2 #NOT ALLOWED
firewall blocks can be single IP, CIDR, or a RANGE
 * single ip: 192.168.1.1
 * CIDR: 192.168.1.0/24
 * ~RANGE: 192.168.1.1-192.168.1.10~ --src-range is not supported in most 1.4.x version of iptables

see the file [iptablesv4.conf](https://raw.githubusercontent.com/BeauBouchard/Sysadmin-scripts/master/etc/iptablesv4.conf) for an example of acceptable formats for an IP range and list.



## tweetmewhenitsdown.pl

 Filename: tweetmewhenitsdown.pl
 
 Author: [@BeauBouchard](http://www.twitter.com/beaubouchard)
 
 Description: This is a script which will tweet you when something breaks... Tweet me When its Down. 
 Its simple, and was a hack that works for me, but maybe some one else can make use it.
 Setup a twitter account, make it private, and follow it with your main account and turn on text alerts to get alerts.
 Pay attention, you will need to set these values below. Get them from here: https://dev.twitter.com/apps/new
 
           consumer_key        => "YOUR CONSUMER KEY HERE",
           
           consumer_secret     => "YOUR SECRET CONSUMER KEY",
           
           access_token        => "YOUR ACCESS TOKEN",
           
           access_token_secret => "YOUR SECRETE ACCESS TOKEN" 


 Make a cronjob to run every ten minutes like this:  */10 * * * * perl /dir/to/script/tweetmewhenitsdown.pl
