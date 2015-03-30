#! /bin/sh
# SIXXS heartbeat script for pfSense - Startscript
#
# The MIT License (MIT)
# Copyright (c) 2015 Andreas Dolp
# 
# By Andreas Dolp <dev[at]andreas-dolp.de>
# Version: v1.0 - 2015-03-30

SCRIPT=/usr/local/bin/sixxs-heartbeat.sh
 
PIDFILE=/var/run/sixxs-heartbeat.pid

rc_start() {
	if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
		echo '[SixXS heartbeat] Script already running' >&2
		return 1
	fi
	echo '[SixXS heartbeat] Starting script…' >&2
	$SCRIPT &
	echo $! > "$PIDFILE"
	echo '[SixXS heartbeat] Script started' >&2
}

rc_stop() {
	if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
		echo '[SixXS heartbeat] Script not running' >&2
		return 1
	fi
	echo '[SixXS heartbeat] Stopping script…' >&2
	kill -15 $(cat "$PIDFILE") && rm -f "$PIDFILE"
	echo '[SixXS heartbeat] Script stopped' >&2
}

case "$1" in
	start)
		rc_start
		;;
	stop)
		rc_stop
		;;
	restart)
		rc_stop
		rc_start
		;;
	*)
		echo "Usage: $0 {start|stop|restart}"
esac
