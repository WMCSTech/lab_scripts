#!/bin/bash
# Created by Dustin Palmer - April 20, 2016

# Script was created from the Red Hat Linux - Sams Teach Yourself
# Unix System Administration book. Chapter 3 - Disk Usage

echo "Disk Hogs Report for System $HOST"

#Variables
DIRECTORY=home
BIGDIR2=$(du -sh /$DIRECTORY/* | sort -rn | cut -f2 | head -5)

echo "The five biggest library directories are: "
echo "$BIGDIR2"


for DIRNAME in $BIGDIR2
do
	echo ""
	echo "Big directory: $DIRNAME"
	echo "Five largest files in that directory are: "
	find $DIRNAME -type f -printf "%k %p\n" | sort -rn | head -5
done
exit 0