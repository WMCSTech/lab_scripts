#!/bin/bash
##Created by Dustin Palmer - March 8, 2016

##Script displays list of hosts sorted whether they are up or down and
##sends only the downed terminals to the email specified in the script.

##Used for debugging. Comment out to use.
#exec 5> debug_output.txt
#BASH_XTRACEFD="5"

################### SCRIPT BEGIN ###################


# This is added so that a cronjob can run this file
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0

# Variables
SYSUP=$(uptime | awk '{print $2" "$3" "$4}' | sed 's/,//g') #sed strips the comma off the end of uptime
LOGDATE=$(date +"%Y-%m-%d_%H:%M")
REPORT="$LOGDATE"_sysreport.log #amends logdate to report name

EMAIL="foo@bar.com" #change email to recieve notification
LOGLOCATION="/some/directory" #change to where you want the log file to go

# Array containing all terminal hostnames, replace with your own IP's or hostnames
all=( "IP/HOSTA" "IP/HOSTB" "IP/HOSTC" )

for i in ${all[@]}
do
	ping -c2 $i &> /dev/null #pings machines in array, may need to increase count if 1 doesn't work.
	if [ "$?" -gt 0 ] #anything greater than 0 means the machine is up, #? returns previous command results
	then
		echo "$i is down"
	else
		echo "$i has been $SYSUP"
	fi
done >> $REPORT

# Line is used to determine boolean value. 
# If down is found returns 1, if nothing is down returns 0
# nothing is sent through email if down isn't found.
SYSISDOWN=$(cat $REPORT | grep -q "down"; echo $?)

# Sends email if anything terminal is down
if [ "$SYSISDOWN" -eq 0 ]
	then
		cat $REPORT | grep down | mail -s "Downed Terminals" $EMAIL
	else
		echo "All systems are up."
fi

# Checks to make sure the directory specified exists
# If directory exists, moves report
# If not, creates directory and moves report
if [ ! -d $LOGLOCATION ]
	then
		mkdir $LOGLOCATION
		mv $REPORT $LOGLOCATION
	else
		mv $REPORT $LOGLOCATION
fi

################### SCRIPT END ###################
