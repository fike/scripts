#!/bin/sh
# Script to random gnome3 wallpaper
# 
DIR="Directory_images_here"

# Original script is here http://www.tuxarena.com/2011/12/gnome-3-how-to-change-the-wallpaper-from-command-line/

while true
do
	for i in $(echo $DIR/*)
	do
   		gsettings set org.gnome.desktop.background picture-uri "file:///$i"
		sleep 300
done
done


