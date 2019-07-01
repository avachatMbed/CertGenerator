#!/usr/bin/env bash

if [ $# -ne 4 ]
then
   echo "Usage $0 dirName key_file_name config_file_name crt_file_name"
   exit 1
fi

DIR_NAME=$1
KEY_FILE="$DIR_NAME"/"$2"
CONFIG_FILE="$DIR_NAME"/"$3"
CRT_FILE="$DIR_NAME"/"$4"


if [ ! -d $DIR_NAME ]
then
    echo "Directory $DIR_NAME does not exist"
    exit 1
fi

if [ ! -f $KEY_FILE ]
then
    echo "Key file $KEY_FILE does not exist"
    exit 1
fi

if [ ! -f $CONFIG_FILE ]
then
    echo "Config file $CONFIG_FILE does not exist"
    exit 1
fi

if [ -f $CRT_FILE ]
then
    echo "CRT file $CRT_FILE already exists"
    exit 1
fi

echo "Generating CRT : $CRT_FILE"
openssl req -x509 -new -nodes -key $KEY_FILE -sha256 -days 1024 -config $CONFIG_FILE -out $CRT_FILE
