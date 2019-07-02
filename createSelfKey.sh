#!/usr/bin/env bash


if [ $# -ne 0 ]
then
   echo "Usage:: $0 <use env.sh to set the parameters"
   exit 1
fi

#####
# Initialize all the variables
#
. env.sh


#####
# Defensive checks
if [ ! -d $SELF_DIR ]
then
    echo "Directory $SELF_DIR does not exist"
    exit 1
fi

# Key file
KEY_FILE=$SELF_DIR/$SELF_KEY
if [ -f $KEY_FILE ]
then
    echo "Key file $KEY_FILE does not exist"
    exit 1
fi

echo "Generating KEY : $KEY_FILE"
openssl ecparam -out $KEY_FILE -name prime256v1 -genkey
### PREV COMMAND ### openssl genrsa -des3 -out $KEY_FILE 2048

