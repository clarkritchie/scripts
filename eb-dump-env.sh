#!/usr/bin/env bash
#
# Dump the env vars for each ElasticBeanstalk environment
# to a file named [environment].env
#
eb list | sed 's/* //' | while read -r ebenv ; do
	TMP=`mktemp`
	FILE=$ebenv.env
	echo "Dumping env vars for $ebenv"
    eb printenv $ebenv \
   	| sort -k1,1 -k2n > $TMP # sort them alphabetically
   	sed '$d' $TMP > $FILE # remove the last line which contains "Environment"
   	rm -f $TMP
done