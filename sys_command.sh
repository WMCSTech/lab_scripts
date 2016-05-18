#!/bin/bash
##Created by Dustin Palmer - March 15, 2016
##dlp2016_04_05 - Added Usage if statement and added if statements to catch
##the $2 variable. 
##dlp2016_05_16 - Added a custom usage and a wake command.

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

#dlp2016_04_05
# Variables
ALL=( IP/HOSTA IP/HOSTB IP/HOSTC IP/HOSTD IP/HOSTD ) # All terminal names or IP addresses
LAB1=( IP/HOSTA IP/HOSTB IP/HOSTC ) # Specific names of terminals or IP addresses
OPTIONS=( restart mirror update wake custom ) # Add action arguments that you want to check against (mirror, restart, etc)
#dlp2016_05_16
LABNAME=( all lab1 ) # Add LAB variables here (lab1, lab2, etc)

# Usage clause in case proper terminology isn't used
if [[ ! $# == 2 ]] || [[ ! ${OPTIONS[*]} =~ $1 ]] || 
	[[ ! ${LABNAME[*]} =~ $2 && ! ${ALL[*]} =~ $2 ]]; then 
  echo "Usage: $0 {restart/mirror/update/wake/custom} {labname/machinename}"
  exit
fi

# Array containing all terminal hostnames, replace with your own IP's or hostnames
if [[ "$2" == all ]];then
	IP=$ALL
elif [[ "$2" == LABNAME 2 ]]; then
	IP=$LAB1
else
	IP=$2 # Captures name of single machine specified
fi
#dlp2016_04_05

# Actions
if [[ "$1" == restart ]]; then
	for i in ${IP[@]}; do
			ssh -tA $i "shutdown -r now"
		done
elif [[ "$1" == mirror ]]; then
	for i in ${IP[@]}; do
			ssh -tA $i "mirror"
		done
elif [[ "$1" == update ]]; then
	for i in ${IP[@]}; do
		ssh -tA $i "apt-get install --fix-broken;
			dpkg --configure -a;
			apt-get update;
			apt-get upgrade -y;
			shutdown -r +1";
	done
elif [[ "$1" == custom ]]; then #dlp2016_05_16
	read -p "What's the command? " COMMAND
	for i in ${LAB[@]}; do
		ssh -tA $i "$COMMAND";
	done
elif [[ "$1" == wake ]]; then #dlp2016_05_16
	for i in ${LAB[@]}; do
		ether-wake -i eth0 $i;
	done
else
else
	echo "Argument not found or no argument passed. Closing..."
fi 

#dlp2016_05_16
# LOG VARIABLES
# Logs the commands used
LOGFILE=/var/log/syscommand.log
LOGDATE=$(date +"%Y-%m-%d_%H:%M") 
LOGINFO="$LOGDATE "-" $USER "-" $1 "-" $2 "-" $COMMAND"
echo $LOGINFO >> $LOGFILE

################### SCRIPT END ###################