#!/bin/bash
#
#
RSYNC=$(which rsync)
MONITOR="/etc/monitor/monitor.conf"
#MONITOR="/tmp/teste.txt"
REMOTE="192.168.0.10"


rsync -au $MONITOR root@$REMOTE:$MONITOR

