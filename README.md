I made a couple of scripts for doing some simple sysadmin tasks.


## raiseshields.sh





## tweetmewhenitsdown.pl


This is a script which will tweet you when something breaks... Tweet me When its Down

 Filename: tweetmewhenitsdown.pl
 
 Author: [@BeauBouchard](http://www.twitter.com/beaubouchard)
 
 
 Description: This will tweet me when my other script is down. 
 Its simple, and was a hack that works for me, but maybe some one else can make use it.
 Setup a twitter account, make it private, and follow it with your main account and turn on text alerts to get alerts.
 Pay attention, you will need to set these values below. Get them from here: https://dev.twitter.com/apps/new
 
           consumer_key        => "YOUR CONSUMER KEY HERE",
           
           consumer_secret     => "YOUR SECRET CONSUMER KEY",
           
           access_token        => "YOUR ACCESS TOKEN",
           
           access_token_secret => "YOUR SECRETE ACCESS TOKEN" 


 Make a cronjob to run every ten minutes like this:  */10 * * * * perl /dir/to/script/tweetmewhenitsdown.pl
