#!/bin/sh

MYSQLDUMP=$(which mysqldump)
USER="user"
DATABASES[0]=" "
DATABASES[1]=" "
DATABASES[2]=" "
DATABASES[3]=" "
DATABASES[4]=" "
DATABASES[5]=" "
PASSWORD=" "

for i in ${DATABASES[@]};do
	    $MYSQLDUMP -u $USER -p$PASSWORD $i| gzip > $i.sql.gz
done

