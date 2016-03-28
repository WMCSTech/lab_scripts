#!/bin/bash
##Created by Dustin Palmer - March 15, 2016

##Script is to be used in a cron job and requires an argument to be passed.
##Should not have any user input besides that. The sys_admin script will 
##do all the other work that requires questions.

##Used for debugging. Comment out to use.
#exec 5> debug_output.txt
#BASH_XTRACEFD="5"

################### SCRIPT BEGIN ###################


# This is added so that a cronjob can run this file
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0

# Array containing all terminal hostnames, replace with your own IP's or hostnames
all=( "IP/HOSTA" "IP/HOSTB" "IP/HOSTC" )

if [[ "$1" == restart ]]; then
	for i in ${all[@]}; do
			ssh -tA $i "shutdown -r now"
		done
elif [[ "$1" == mirror ]]; then
	for i in ${all[@]}; do
			ssh -tA $i "mirror"
		done
elif [[ "$1" == update ]]; then
	for i in ${all[@]}; do
		ssh -tA $i "dpkg --configure -a;
			apt-get update;
			apt-get upgrade -y;
			shutdown -r +1";
	done
else
	echo "Argument not found or no argument passsed. Closing..."
fi

################### SCRIPT END ###################