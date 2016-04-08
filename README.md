# lab_scripts

#DISCLAIMER

This repository is primarily for new linux system administrators. 

Use freely to your own needs. No warranty provided, and I take no responsiblities for issues the scripts may cause
or for what purposes they are used for. I'm posting them simply for my own records and to make sure what I've learned
is passed on to future generations of programmers and scripters. 

If you have any questions, please direct them to palmerdl@whitman.edu.

Thanks,
Dustin




#DESCRIPTION OF SCRIPTS

##wake.pl##

Script wakes up terminals specified in the script. You'll need to place this script on the server or machine you are using as the centralized hub; Preferrably one that stays up the most. 

####INSTALLATION
1. On host server, change to root and open the cron daemon:
su
crontab -e
2. In cron, add the following line of code:
* 7 * * * /location/of/your/script/wake.pl lab
3. Save and exit.

Note the lab argument wakes all computers in the lab up. 

You're all set. Mess with the cron settings to adjust the time you want to 
wake up all the computers. You can even make this script into a command by 
making a symbolic link.

1. On host system, use the following code to make a symlink

ln -s /location/of/your/script/wake.pl /usr/local/bin/wake

2. Open terminal and type: wake <hostname>
This will wake up the specified computer.




##reboot.sh

Super simple if statement script to reboot the computer if it needs to be shutdown.
Checks for the reboot-required file and, if it finds it, reboots the system. Also,
the file confirms the package configuration files, checks for updates, and upgrades.

####INSTALLATION

Make a cron job on the host server to run this script to check if a reboot is required.




##sys_down.sh

Sends report to specified email address concerning down computers and logs whether computers
are up or not. 

####INSTALLATION

1. Modify the variables in the script to your specifications.

2. Create a cron job on the host server to run the script at times you've specified




##mirror.sh

####INSTALLATION






##mirror.py

Credit goes to Jacob Vlijm for the creation of this code. 
Source: https://askubuntu.com/questions/568035/multiple-monitor-mirrored-as-default

####INSTALLATION

Run script from terminal to make the screens default to a mirrored status.


##autonfs.sh

https://help.ubuntu.com/community/AutomaticallyMountNFSSharesWithoutAutofsHowto

####INSTALLATION

See link above




##idlekiller.sh

All credit goes to murukeshm
https://github.com/murukeshm/scratchpad/tree/master/linux/idlekiller

####INSTALLATION

Install xprintidle:
sudo apt-get install xprintidle

Copy the script to /usr/bin/idlekiller, and the Upstart file to /etc/init/idlekiller.conf.

Start the Upstart service:
sudo service idlekiller start

Configuration

It doesn't support many options now. :) You can set:

The idle timeout using the variable IDLE. This is an integer in seconds.
The frequency of checking using the sleep timeout variable TIMEOUT. Since this is passed to sleep as is, you can use syntax that your sleep will understand, such as 10m and 2h.
The grace period after the warning is shown, using the GRACE variable. Also passed to sleep.
The warning message using the IDLE_MESSAGE variable.
To set them, create /etc/default/idlekiller and set the variables in it. The file is sourced, so bash syntax can be used.

I haven't added a way to exclude users from this yet.

Logging
The script logs to syslog using the IDLEKILLER tag.


##sys_command.sh

Used to perform repetitive tasks in the lab.

####INSTALLATION




##sys_down.sh

Uses the finger deamon to check and see if a computer is down. If yes, then it sends an email to a specified user.

####INSTALLATION