#!/usr/bin/perl

# Script originally written by David Guichard 
  # Modified by Dustin Palmer
# 20151210dlp - added comments on how script works
# 20160309dlp - updated location of ether-wake app for use on Hobbes

$debug = 0;

$progname = $0;
$progname =~ s/^\/.*\///;

if ( $#ARGV < 0 ) {
  print "Usage:\n";
  print "   $progname <hostname|lab>\n";
  exit 1;
}

# Contains all of the lab hostnames and mac addresses that could be
# affected if it cannot find them by hostname.
%labmacs = (
  "HOSTNAME"      ,"MAC_ADDRESS", 
  "HOSTNAME"      ,"MAC_ADDRESS");


# 20151210dlp -Code activates computers first by hostname and then by the list above if unable to connect.
# This code needs an application called ether-wake before it will work correctly. 
# You'll need to locate your etherwake script on the server you put this on 
# and modify the script accordingly. You can google a list of applications to find out how 
# to install it. 

$host = $ARGV[0];
if ($host =~ /^([a-z]*)$/ ) { $host = $1; }

if ($host =~ /^lab$/) {
  foreach $key (keys %labmacs) {
    $cmd = "/sbin/ether-wake -i eth0 $labmacs{$key}"; # 20160309dlp - updated
    #20151210dlp - This command is the key; should be able to run by itself

    #$cmd = "/usr/local/sbin/ether-wake $labmacs{$key}"; #20160309dlp - David's original line.
    print "$cmd\n";
    if  (!$debug) { system $cmd; }
  }
} else {
  $cmd = "/sbin/ether-wake -i eth0 ";
  #$cmd = "/usr/local/sbin/ether-wake "; #20160309dlp - commented original line out
  if ($labmacs{$host}) {
    $cmd .= $labmacs{$host};
  } else {
    print "no host $host\n";
    exit 1;
  }
  print "$cmd\n";
  if (!$debug) { system $cmd; }
}