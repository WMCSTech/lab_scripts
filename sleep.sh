#!/bin/bash

# Created by Dustin Palmer - 1/5/2016
# Implemented 1/5/2016

# Script puts the computer to sleep if the right BIOS settings are in place.  
# For automated sleeping, create a cron job on the local machine
# and reference this file. 

# This is added so that a cronjob can run this file.
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0

# Reconstructs the dbus. A requirement before suspending.
# Reference: http://www.pclinuxos.com/forum/index.php?topic=124391.0
dbus_session_file=~/.dbus/session-bus/$(cat /var/lib/dbus/machine-id)-0
if [ -e "$dbus_session_file" ]; then
  . "$dbus_session_file"
  export DBUS_SESSION_BUS_ADDRESS DBUS_SESSION_BUS_PID
dbus-send --session --type=method_call --dest=org.freedesktop.ScreenSaver /ScreenSaver org.freedesktop.ScreenSaver.Lock
fi

# Suspends the computer.
pm-suspend