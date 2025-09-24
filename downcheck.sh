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
CS_DOWN=/root/cs_down.txt
MATH_DOWN=/root/math_down.txt

# Array containing all terminal hostnames, replace with your own IP's or hostnames
cs=(	ritchie tedcodd	pausch	vonneumann	mauchly	gertrudeblanch	keniverson
	goldstine	zuse	jonpostel	atanasoff	landin
	holberton	engelbart	jefraskin	estrin	evinemeth	skolem
	annieeasley	emilpost	quine	nygaard	noyce	bartik	anitaborg
	markweiser	al-khwarizmi	pnueli	gracehopper	anwang	perlis	buituongphong
	lamarr	skipellis	brattain	babbage	fitts	shannon	turing	dijkstra
	backus	jpeckert	adalovelace	jimgray	hollerith )

math=(	aphrodite	apollo	ares	artemis
		athena	coeus	crius	cronus	demeter	dionysus	hephaestus	hera
		hermes	hestia	hyperion	iapetus	mnemosyne	oceanus	phoebe	poseidon
		rhea	tethys	theia	themis	zeus)

for i in ${cs[@]}
do
	finger $USER@$i | grep $USER &> /dev/null #fingers a user on machine; machine can be pinged, but not logged into.
	#ping -c2 $i &> /dev/null #pings machines in array, may need to increase count if 1 doesn't work.
	if [ "$?" -gt 0 ] #anything greater than 0 means the machine is up, #? returns previous command results
	then
		echo "$i, "
	else
		echo ""
	fi
done >> $CS_DOWN

for i in ${math[@]}
do
	finger $USER@$i | grep $USER &> /dev/null #fingers a user on machine; machine can be pinged, but not logged into.
	#ping -c2 $i &> /dev/null #pings machines in array, may need to increase count if 1 doesn't work.
	if [ "$?" -gt 0 ] #anything greater than 0 means the machine is up, #? returns previous command results
	then
		echo "$i, "
	else
		echo ""
	fi
done >> $MATH_DOWN

################### SCRIPT END ###################
