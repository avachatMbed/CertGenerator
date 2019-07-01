#!/usr/bin/env bash

if [ $# -ne 3 ]
then
   echo "Usage $0 [server|client] dirName filename"
   exit 1
fi

KEY_TYPE=""
if [ "$1" = 'server' ]
then
    KEY_TYPE="S"
elif [ "$1" = "client" ]
then
    KEY_TYPE="C"
else
   echo "WRONG KEY TYPE : Usage $0 [server|client] dirName filename"
   exit 1
fi


DIR_NAME=$2
KEY_FILE="$DIR_NAME"/"$3"


if [ ! -d $DIR_NAME ]
then
    echo "Directory $DIR_NAME does not exist"
    exit 1
fi

if [ -f $KEY_FILE ]
then
    echo "$KEY_FILE already exists"
    exit 1
fi

echo "Generating KEY : $KEY_FILE"

if [ $KEY_TYPE = "S" ]
then
    openssl ecparam -name prime256v1 -genkey -out $KEY_FILE
else
    openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:P-256 -pkeyopt ec_param_enc:named_curve \
    | openssl pkcs8 -topk8 -nocrypt -outform pem > $KEY_FILE
fi