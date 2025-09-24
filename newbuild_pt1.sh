#!/bin/bash

# This script is a part one of two. This installs the mounting necessities.
# Written by Dustin Palmer 7/9/2015
# Updated on 7/14/2018 - All Updates are for 18.04 fresh install
# - Recreated because an UEFI BIOS doesn't allow for clonezilla
# - Script retooled to rebuild a computer from scratch
# - Retooled to install ONLY the necessary files to mount profiles
# added sudo systemctl

#### NOTE ####
### To Install Ubuntu, you must disable secure boot and change the boot
### settings to AHCI

#Copying and creating setupfiles directory in root
#echo "Mounting USB and copying setupfiles to the root home directory..."; sleep +2
#mkdir /media/usb
#mkdir ~/setupfiles
#sudo mount /dev/sdb1 /media/usb
#cp /media/usb/setupfiles ~/setupfiles
#echo "Files copied over."; sleep +3
#clear

#Establishes machine root password
#Add prompt if fresh install, then change root password, else carry on
echo "Changing root password..."; sleep +2
sudo passwd root
echo ""
echo "...Root password has been set."; sleep +2
echo "-------------------------"
echo "-------------------------"
clear

# Make local Users
mkdir /usr/local/home
mkdir /usr/local/home/dlp
mkdir /usr/local/home/local
mkdir /usr/local/home/davisjf-la
adduser local
usermod -d /usr/local/home/local local
sudo chown -R local:local /usr/local/home/local
adduser dlp
usermod -d /usr/local/home/dlp dlp
sudo chown -R dlp:dlp /usr/local/home/dlp
adduser davisjf-la
usermod -d /usr/local/home/davisjf-la davisjf-la
sudo chown -R davisjf-la:davisjf-la /usr/local/home/davisjf-la

#Installs latest updates and distribution upgrades
echo "Checking for latest updates and upgrades..."
sudo apt -y update; apt upgrade -y; apt -y dist-upgrade; sudo apt dist-upgrade -y; sudo dpkg --configure -a; sudo apt autoremove -y
echo ""
echo "Upgrades complete!"; sleep +2
echo "-------------------------"
echo "-------------------------"
clear

#Configures home directories using automount
echo "Installing autofs for mounting home directories from Hobbes..."; sleep +3
sudo apt -y install autofs
echo "-------------------------"
echo "-------------------------"
echo "autofs completed"; sleep+3
clear

echo "Installing SSH, Vim, Synaptic, Kerberos user and its libraries.."; sleep +3
sudo apt install openssh-server -y
# Outdated
#sudo apt install vim-gnome -y
sudo apt install vim -y
sudo apt install synaptic -y
sudo apt install krb5-user -y
#When prompted math.whitman.edu once, hobbes.whitman.edu twice
sudo apt install libpam-krb5 -y
sudo apt install lightdm -y
#lightdm is REQUIRED for 18.04. When prompted choose lightdm
echo "All required software installed."; sleep +3
clear


#Replaces /etc/auto.home and /etc/auto.master with Setup Files downloaded from the Group Drive which should be done before hand.
#IMPORTANT the downloaded files must be in the ./SetupFiles/ directory for this to work
echo "Replacing autofs configuration files..."; sleep +2
sudo cp /root/setupfiles/auto.home /etc/
sudo cp /root/setupfiles/auto.master /etc/
#this line can no longer be used for 18.04
#sudo cp ~/setupfiles/fstab /etc/
echo "-------------------------"
echo "-------------------------"
echo "autofs configuration complete."; sleep +3

echo "Adding autonfs.sh script to /usr/local/bin"; sleep +2
#Newly added dlp2018.06.26 - adds script that will allow mounting to be automatically downloaded
sudo cp /root/setupfiles/autonfs.sh /usr/local/bin/
chmod a+x /usr/local/bin/autonfs.sh
echo "_________________________"
echo "-------------------------"
sleep +2

#Mounts Distribution directory from NFS
echo "Creating autonfs service..."; sleep +2
sudo cp /root/setupfiles/autonfs.service /lib/systemd/system
sudo cp /root/setupfiles/systemd-logind.service /lib/systemd/system/
sudo systemctl start autonfs
sudo systemctl enable autonfs
sudo systemctl stop autonfs
echo "-------------------------"
echo "-------------------------"
echo "AutoNFS service completed"; sleep +3

echo "Updating host and hostname information"; sleep +2
#Opens an editor so that a person can update the IP and Hostname
sudo cp /root/setupfiles/hosts /etc
echo "-------------------------"
echo "-------------------------"
sleep +2

echo "Configuring NIS/YP/Kerberos. When prompted add math.whitman.edu"; sleep +3
#Configures NIS/YP/Kerberos
#When prompted enter: math.whitman.edu
sudo apt-get -y install nis
echo "-------------------------"
echo "-------------------------"
echo "Configuration complete."; sleep +3

#Replaces /etc/yp.conf and /etc/nsswitch.conf with Setup Files
echo "Replacing yp.conf, krb5.conf and nsswitch.conf..."; sleep +3
sudo cp /root/setupfiles/yp.conf /etc/
sudo cp /root/setupfiles/nsswitch.conf /etc/
sudo cp /root/setupfiles/krb5.conf /etc/
echo "-------------------------"
echo "-------------------------"
echo ""
echo "yp.conf and nsswitch.conf replaced."; sleep +2
clear

#Replaces files in the /etc/pam.d folder with Setup Files
echo "Replacing pam.d configuration files common-auth, login and common-krb5..."; sleep +3
sudo cp /root/setupfiles/pam.d/common-auth /etc/pam.d/
sudo cp /root/setupfiles/pam.d/login /etc/pam.d/
sudo cp /root/setupfiles/pam.d/common-krb5 /etc/pam.d/
echo "-------------------------"
echo "-------------------------"
echo "common-auth, login, and common-krb5 have been replaced."; sleep +2
clear

#Creates folder /etc/lightdm/lightdm.conf.d and places 50-myconfig.conf into the Home directory
#This file hides userids and allows use of non-local userids in login screen, lightdm
echo "Making lightdm.conf.d directory and putting in 50-myconfig.conf in it..."; sleep +3
#sudo mkdir /etc/lightdm/lightdm.conf.d
sudo cp /root/setupfiles/50-myconfig.conf /etc/lightdm/lightdm.conf.d/
echo "-------------------------"
echo "-------------------------"
echo "50-myconfig.conf file installed."; sleep +2
clear

# Fixes the udev package so you can use apt-get upgrade
#UPDATE 6.10.2021 dlp - Ubuntu 20.04 doesn't need this.
#cat > /usr/sbin/policy-rc.d <<EOF
#!/bin/sh
#exit 101
#EOF
#chmod +x /usr/sbin/policy-rc.d
#dpkg-divert --local --rename --add /sbin/initctl
#ln -s /bin/true /sbin/initctl

#IMPORTANT if you did do-release-upgrade from 18.04 to 20.04
# you'll need to run this command:
# mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.old
# rm /bin/true

# #Changes adds local user and changes over local users to new home directory
# echo "Moving local home directories..."; sleep +3
# adduser local
# usermod -d /usr/local/home/local local
# sudo chown -R local:local /usr/local/home/local
# usermod -d /usr/local/home/dlp dlp
# sudo chown -R dlp:dlp /usr/local/home/dlp
# echo "------------------------"
# echo "local directories moved from /home to /usr/local/home."; sleep +2
# clear

#Fixes ypbind not starting at reboot
# courtesy of: https://www.marcus-povey.co.uk/2020/10/05/fixed-nis-not-working-after-upgrading-to-ubuntu-20-04/#comments
sudo cp /root/setupfiles/nis /etc/default/
# removes -no-dbus from YPBINDARGS= argument

#echo "Initial new machine configuration completed. Rebooting..."; sleep +3
#sudo reboot
