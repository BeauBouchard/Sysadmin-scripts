#!/usr/bin/perl
use strict;
use Net::Twitter::Lite;
use Date::Parse qw( str2time );
use Date::Format qw( time2str);

# Filename: tweetmewhenitsdown.pl
# Author: Beau Bouchard (Beau@beaubouchard.com) http://www.twitter.com/beaubouchard
# Date: 07-12-2012
# 
# Description: This will tweet me when my other script is down. 
# Its simple, and was a hack that works for me, but maybe some one else can make use it.
# 

# Setup a twitter account, make it private, and follow it with your main account and turn on text alerts to get alerts.
#	Pay attention, you will need to set these values below. Get them from here: https://dev.twitter.com/apps/new
#           consumer_key        => "YOUR CONSUMER KEY HERE",
#           consumer_secret     => "YOUR SECRET CONSUMER KEY",
#           access_token        => "YOUR ACCESS TOKEN",
#           access_token_secret => "YOUR SECRETE ACCESS TOKEN" 
#
#
# Make a cronjob to run every ten minutes like this:  */10 * * * * perl /dir/to/script/tweetmewhenitsdown.pl


	my $perlcount;
	$perlcount = `ps -ef | grep -c "scriptname.pl"`;
	#when this script runs it will count the number of "scriptname.pl" which appear in the process list
	#the first process will be the running script, the second two will be the ps, and the grep which will also contain the name
	
	my $time = &getDateTime();
	print $perlcount;
	
	if(  $perlcount< 3 )
	{
		tweetout("THE Script is Down!",$time);
	}
	else
	{
		#tweetout("Script is Up",$time); #us this if you want it to tweet when the script is up
		#also great for testing
	}
	
	
sub tweetout
{
   	my $status = shift;
	my $datetime = shift;
	my $return_value = 1;
	my $result;

         my $nt = Net::Twitter::Lite->new(
           consumer_key        => "YOUR CONSUMER KEY HERE",
           consumer_secret     => "YOUR SECRET CONSUMER KEY",
           access_token        => "YOUR ACCESS TOKEN",
           access_token_secret => "YOUR SECRETE ACCESS TOKEN" 
         );
         #$result = eval {$nt->update({status => "$loc $totnum\n$datetime", lat => $tlat, lon => $tlon})};
         
			$result = eval {$nt->update({status => "$status at $datetime"})};
         
         warn "$@\n" if $@;
          print "Tweet sent\n";

}

sub getDateTime
{
	my @timeStamp;
	my $CurrentTime;
	
	@timeStamp = gmtime(time);
	my $year 	= 1900 + $timeStamp[5];
    my $month 	= 1 + $timeStamp[4];
	my $day 		= $timeStamp[3];
	my $hour 	= $timeStamp[2];
	my $min 		= $timeStamp[1];
	my $sec 		= $timeStamp[0];
	
	if($sec<10){$sec="0$sec";}
	if($min<10){$min="0$min";}
	if($hour<10){$hour="0$hour";}
	if($day<10){$day="0$day";}
	if($month<10){$month="0$month";}
	
	$CurrentTime = "[$year\/$month\/$day - $hour\:$min\:$sec]";
	return $CurrentTime;
}
1;
