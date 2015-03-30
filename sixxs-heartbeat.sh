#! /bin/sh
# SIXXS heartbeat script for pfSense
#
# The MIT License (MIT)
# Copyright (c) 2015 Andreas Dolp
# 
# By Andreas Dolp <dev[at]andreas-dolp.de>
# Version: v1.0 - 2015-03-30

### CONFIG ###
remotev4=""	# FQDN or IPv4 of TIC, e.g. demuc02.sixxs.net
localv6=""	# Your IPv6 - your private tunnel endpoint
password=""	# The hashed sixxs heartbeat password, found on "live tunnel status"
interval="60"	# Interval for sending heartbeats	
debug=0	# Set to 1 if you want to see outputs
### END CONFIG ###


while [ 1 ]
do
	ha="HEARTBEAT TUNNEL `echo -n $localv6` sender `date +%s`"

	hb="`echo -n $ha` `echo -n $password`"
	hc=`echo -n "$hb" | md5 | cut -d ' ' -f 1`

	if [ $debug -eq 1 ]; then
		echo "Sending: `echo -n $ha` `echo -n $hc`"
	fi

  echo -n "`echo -n $ha` `echo -n $hc`" | nc -4 -u -w 1 $remotev4 3740
	sleep $interval
done
