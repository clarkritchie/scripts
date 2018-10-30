#!/usr/bin/env bash
#
# crazy quick and dirty script to copy Elastic Beanstalk env vars from
# one environment to another
#
# ./eb-cp-env.sh source target
# outputs the command for you to execute -- just copy and paste, it does not execute the command!
#
# ./eb-cp-env.sh source target execute
# executes the command -- use with cautio!
#


if [ -z "$1" ]; then
    echo "No from environment specified"
    echo "Usage $0 from_environment to_environment"
    exit
fi

if [ -z "$2" ]; then
    echo "No to environment specified"
    echo "Usage $0 from_environment to_environment"
    exit
fi

execute=false
if [[ $3 = "execute" ]]; then
   execute=true
fi


FROM_ENVIRONMENT=$1
TO_ENVIRONMENT=$2

# make temp files
# using this technique to avoid bash "File name too long" errors
tempfoo=`basename $0`
tempfoo=`basename $0`
FILE=`mktemp /tmp/${tempfoo}.XXXXXX` || exit 1
FILE2=`mktemp /tmp/${tempfoo}.XXXXXX` || exit 1

# skip first line
# sqash whitespace around = character
# do not copy over SECRET_KEY_BASE
# sort alphabetically
eb printenv $FROM_ENVIRONMENT \
    | sed -n '1!p' \
    | sed 's/ //g' \
    | grep -v SECRET_KEY_BASE \
    | sort -t: -k 2 \
    > $FILE

# appends \ to each line
awk '{print $0" \\"}' $FILE > $FILE2 && mv $FILE2 $FILE

# print the command the user can copy-paste into a shell to update the new environment
if $execute; then
    # this will actually execute the command
    # sed removes the \ we just added above
    eb setenv -e $TO_ENVIRONMENT `sed 's/.$//' $FILE`
else
    echo
    echo "Run this command to update $TO_ENVIRONMENT with env vars from $FROM_ENVIRONMENT:"
    echo
    echo -n "eb setenv "    
    echo "$(cat $FILE)"
    echo -n "-e $TO_ENVIRONMENT"
    echo
fi

# cleanup temp file
# echo $FILE
rm -f $FILE