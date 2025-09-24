#!/bin/bash

# This script connects to the professor's local account on Hobbes and
# runs the change password command script.

echo "Enter student username: "
read username
student=$username

echo "Enter local admin account username: "
read local

ssh -t $local@hobbes.whitman.edu "sudo /usr/sbin/kadmin.local -q 'change_password $student'"


exit
