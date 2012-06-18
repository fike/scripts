#!/bin/bash

A=" "
B=" "
C=" "
D=" "
E=" "
CURL=$(which curl)
LOOP1="10"
LOOP2="10"
TARGET="http://www.domain.net"
PARAMETERS=" "
AGENT=" "

for y in $(seq 1 $LOOP1); do
	for i in $(seq 1 $LOOP2); do
	$CURL --user-agent "$AGENT" $PARAMETERS -H "$PRAGMAS" $TARGET?$A+$i+$y > /dev/null &
	$CURL --user-agent "$AGENT" $PARAMETERS -H "$PRAGMAS" $TARGET?$B+$i+$y > /dev/null&
	$CURL --user-agent "$AGENT" $PARAMETERS -H "$PRAGMAS" $TARGET?$C+$i+$y > /dev/null &
	$CURL --user-agent "$AGENT" $PARAMETERS -H "$PRAGMAS" $TARGET?$D+$i+$y > /dev/null &
	$CURL --user-agent "$AGENT" $PARAMETERS -H "$PRAGMAS" $TARGET?$E+$i+$y > /dev/null &
	done
done
