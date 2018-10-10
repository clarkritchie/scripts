#!/usr/bin/env bash
#
# crazy quick and dirty script to copy Elastic Beanstalk env vars from
# one environment to another
#
# ./copyenv.sh source target
#
# outputs the command for you to execute -- just copy and paste
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

FROM_ENVIRONMENT=$1
TO_ENVIRONMENT=$2

# make a temp file
FILE=`mktemp`

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
cat $FILE

# print the command the user can copy-paste into a shell to update the new environment

echo
echo "Run this command to update $TO_ENVIRONMENT with env vars from $FROM_ENVIRONMENT:"
echo
echo -n "eb setenv "

# append \ to each line
awk '{print $0, "\\"}' $FILE
echo -n "-e $TO_ENVIRONMENT"
echo

# cleanup temp file
rm -f $FILE