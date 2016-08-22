#!/bin/bash

# Written by Dustin Palmer, July 1, 2016

# Installs the latest version of Epoptes on 14.04 LTS

# For some reason the standard version of Epoptes was opening
# and then closing rapidly on 14.04 Ubuntu. However, it runs
# great on 16.04. This adds the proposed ppa for 14.04 which
# has issues, but does install Epoptes.

#VARIABLES
EPDIR="/usr/local/bin/epoptes"
PPA="epoptes/proposed"


# Check to see if running as root
if [[ $USER != root ]] ; then
	echo "You are logged in as $USER, you must be root to run this script."
	exit
fi

# Pulls user list from hobbes
scp user@server:/home/user/userlist.txt / 

# Function checks to see if user exists in group and if not, adds them
addusers ()
{
	while IFS='' read -r LINE || [[ -n "$LINE" ]]; do
		if ! grep -q "epoptes" /etc/group; then # Checks to see if group 'epoptes' exists
			groupadd epoptes # Creates group 'epoptes'
			gpasswd -a $LINE epoptes # Adds users to group 'epoptes'
		else
			if ! grep -q $LINE /etc/group; then # Checks to see if the user is in the list
				gpasswd -a $LINE epoptes
			fi
		fi
	done < /userlist.txt
}

# Checks to see if the PPA defined in the $PPA variable exists, if not, installed 
if ! grep -q -a "$PPA" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
	add-apt-repository ppa:epoptes/proposed
	apt-get update
fi

while read -p "{C}lient or {S}erver? " TYPE; do # Server is for the Host PC (teaching station)
	if [[ $TYPE =~ ([ Ss ])$ ]] || [[ $TYPE =~ ([ "Server" ])$ ]] || [[ $TYPE =~ ([ "server" ])$ ]]; then

		apt-get install epoptes -y # Installs epoptes
		apt-get install -f # Forces installation
		
		addusers # Adds all users from Hobbes to the epoptes group

		# Allows all epoptes users to run the epoptes service

		echo "%epoptes 	ALL=NOPASSWD: /usr/sbin/service epoptes *" >> /etc/sudoers

		# Create epoptes symlink
		touch $EPDIR
		echo "#!/bin/bash" >> $EPDIR 
		echo "sudo service epoptes --full-restart" >> $EPDIR
		echo "/usr/bin/epoptes" >> $EPDIR

		break

	elif [[ $TYPE =~ ([ Cc ])$ ]] || [[ $TYPE =~ ([ "Client" ])$ ]] || [[ $TYPE =~ ([ "client" ])$ ]]; then

		apt-get install epoptes-client -y # Installs epoptes client
		addusers # Adds users from Hobbes to epoptes group

		# Adds server if there isn't already one specified
		if ! grep -q "server" /etc/hosts ; then
			echo "Known IP's: X.X.X.X = server1, X.X.X.X = server2, X.X.X.X = server3"
			read -p "Type in the IP Address of the Host: " IP
			echo "$IP	server" >> /etc/hosts #Required for clients to find the host server
		fi

		epoptes-client -c #Retrieves SSL Cert from host

		break

	else
		echo "You did not pick a correct option. Type in C for client or S for server."
	fi
done

# Delete userlist and reboot
rm /userlist.txt
shutdown -r +1

### UNUSED CODE FOR A CASE STATEMENT

# OPTIONS=("C" "c" "S" "s" "client" "Client" "server" "Server" "Quit")

# select opt in "${options[@]}"
# do
# 	case $opt in
# 		"C"|"c"|"client"|"Client")
# 			apt-get install epoptes-client -y # Installs epoptes client
# 			addusers # Adds users from Hobbes to epoptes group

# 			# Adds server if there isn't already one specified
# 			if ! grep -q "server" /etc/hosts ; then
# 				echo "Known IP's: X.X.X.X = server1, X.X.X.X = server2, X.X.X.X = server3"
# 				read -p "Type in the IP Address of the Host: " IP
# 				echo "$IP	server" >> /etc/hosts #Required for clients to find the host server
# 			fi

# 			epoptes-client -c #Retrieves SSL Cert from host
# 			;;
# 		"S"|"s"|"server"|"Server")
# 			apt-get install epoptes -y # Installs epoptes
# 			apt-get install -f # Forces installation
			
# 			addusers # Adds all users from Hobbes to the epoptes group

# 			# Allows all epoptes users to run the epoptes service

# 			echo "%epoptes 	ALL=NOPASSWD: /usr/sbin/service epoptes *" >> /etc/sudoers

# 			# Create epoptes symlink
# 			touch $EPDIR
# 			echo "#!/bin/bash" >> $EPDIR 
# 			echo "sudo service epoptes --full-restart" >> $EPDIR
# 			echo "/usr/bin/epoptes" >> $EPDIR
# 			;;
# 		"Quit")
# 			break
# 			;;
# 		*) echo invalid option;;
# 	esac
# done