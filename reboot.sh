#!/bin/bash
##Created by Dustin Palmer - March 8, 2016

##Script logs reboot date and time to a log file and reboots the
##terminal is if the reboot-required file is found on the system.

# This is added so that a cronjob can run this file.
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0

if [ -f /var/run/reboot-required ] 
	then
		# Check update configurations
		dpkg --configure -a
		apt-get update
		apt-get upgrade -y
		# Restarts the computer in 5 minutes.
		shutdown -r +5
fi