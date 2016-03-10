#!/usr/bin/env python3

# Credit goes to Jacob Vlijm for the creation of this code. 
# Source: https://askubuntu.com/questions/568035/multiple-monitor-mirrored-as-default

# Script mirrors the output of all connected terminals. 

import subprocess

output = subprocess.check_output(["/bin/bash", "-c", "xrandr"]).decode("utf-8").split()
connected = [output[i-1] for i in range(len(output)) if output[i] == "connected"]
command = "xrandr --output "+connected[0]+" --auto --same-as "+connected[1]
subprocess.Popen(["/bin/bash", "-c", command])