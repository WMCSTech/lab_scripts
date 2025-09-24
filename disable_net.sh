#!/bin/bash

while read -u10 HOST ; do ssh -tA $HOST "sudo iptables -A OUTPUT -p all -m owner --uid-owner local -j DROP" ; done 10< cslab165.txt 
