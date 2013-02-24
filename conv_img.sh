#!/bin/bash
# 
# Simple script to length image optimization.
# Fernando Ike - fike@midstorm.org.
# 
#
#
DIR=$HOME/d/octopress/source/images

CONVERT=$(which convert)
PNGCRUSH=$(which pngcrush)
LS=$(which ls)
MV=$(which mv)

for i in $($LS $DIR/*.jpg)
	do 
	$CONVERT -strip -interlace Plane $i $i.new > /dev/null
	$MV $i.new $i 
	done

for i in $(LS $DIR/*.png)
	do $PNGCRUSH -rem alla -brute -reduce $i $i.new > /dev/null 
	$MV $i.new $i
done

