use strict;
use Date::Parse qw( str2time );
use Date::Format qw( time2str) ;

##########################################################################################
# Function: 		error_msg
# Description: makes outputing errors and other content to the log more streamline :P 
# @Param : $erErrormsg  	-- 	This will be an error message which will be used
# @Param : $erLineNumber 	--	The linenumber where the error occured  __
# If $verb is true, we are in verbose mode, if it is false, there will be no output
# Usage: error_msg("Error message here", __LINE__, 1);
##########################################################################################
sub error_msg
{
	my $erErrormsg = shift;
	my $erLineNumber = shift;
	my $erRunType = shift;
	my @errtimeStamp;
	my $errCurrentTime;
	
	@errtimeStamp = gmtime(time);
	my $erryear 	= 1900 + $errtimeStamp[5];
    my $errmonth 	= 1 + $errtimeStamp[4];
	my $errday 		= $errtimeStamp[3];
	my $errhour 	= $errtimeStamp[2];
	my $errmin 		= $errtimeStamp[1];
	my $errsec 		= $errtimeStamp[0];
	
	if($errsec<10){$errsec="0$errsec";}
	if($errmin<10){$errmin="0$errmin";}
	if($errhour<10){$errhour="0$errhour";}
	if($errday<10){$errday="0$errday";}
	if($errmonth<10){$errmonth="0$errmonth";}
	
	$errCurrentTime = "$erryear\/$errmonth\/$errday - $errhour\:$errmin\:$errsec";
	my $lgerrMsg = "##Tedect Error## :: $erErrormsg  , at $erLineNumber";
	
	log_msg("[$errCurrentTime] :: $lgerrMsg"); #errors are also logged in the log
}

##########################################################################################
# Function: 		log_msg
# Description: Checks to see if there is a log which exists for the day, and appends to it,
# if there is no log for today, it makes a new one.
# @Param : $incoming log message
# $spverbose is a global variable which can be turned to 1, or 0
# 
##########################################################################################
sub log_msg
{
	my $lgLogMsg = shift;
	my $fullLogFileDir; # needs to be the path to where you would like to save your log files, ie ./logs/
	my $logFileName;
	my @logtimeStamp;
	my $logCurrentTime;
	   
	@logtimeStamp = gmtime(time);
	my $logyear 	= 1900 + $logtimeStamp[5];
    my $logmonth 	= 1 + $logtimeStamp[4];
	my $logday 		= $logtimeStamp[3];
	my $loghour 	= $logtimeStamp[2];
	my $logmin 		= $logtimeStamp[1];
	my $logsec 		= $logtimeStamp[0];
	
	if($logsec<10){$logsec="0$logsec";}
	if($logmin<10){$logmin="0$logmin";}
	if($loghour<10){$loghour="0$loghour";}
	if($logday<10){$logday="0$logday";}
	if($logmonth<10){$logmonth="0$logmonth";}
	
	$logFileName = "$logyear$logmonth$logday.log"; #creates a log for the day, and then saves it to the log dir
	$fullLogFileDir = "$logFileDir$logFileName";

	$logCurrentTime = "$logyear\/$logmonth\/$logday - $loghour\:$logmin\:$logsec";
	
	if(-e $fullLogFileDir)
	{
		#log exists, write to log normally
		open(LOG,">>$fullLogFileDir") || die("Cannot Open File: $fullLogFileDir");
		print LOG "[$logCurrentTime] :: $lgLogMsg\n";
		close(LOG);
	}
	else
	{
		#file needs to be generated
		print "[log_msg] :: No file found at $fullLogFileDir\n";
		print "[log_msg] :: Log file does not exist, needs to be generated\n";
		
		##changemelater##
		open(LOG,">$fullLogFileDir") || die("Cannot Open File");
		
		print LOG "[$logCurrentTime] STARTING NEW LOG FILE ~ \<3\n";
		
		print LOG "[$logCurrentTime] :: $lgLogMsg\n";
		close(LOG);
	}
		if($spverbose == 1 )
		{
			print "[$logCurrentTime] :: $lgLogMsg\n";
		}
}
