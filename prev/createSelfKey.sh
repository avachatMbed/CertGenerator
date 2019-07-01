#!/usr/bin/env bash


if [ $# -ne 2 ]
then
   echo "Usage $0 dirName filename"
   exit 1
fi

DIR_NAME=$1
KEY_FILE="$DIR_NAME"/"$2"


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
openssl genrsa -des3 -out $KEY_FILE 2048
