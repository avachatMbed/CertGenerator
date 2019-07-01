#!/usr/bin/env bash

if [ $# -ne 4 ]
then
   echo "Usage $0 dirName key_file_name config_file_name csr_file_name"
   exit 1
fi

DIR_NAME=$1
KEY_FILE="$DIR_NAME"/"$2"
CONFIG_FILE="$DIR_NAME"/"$3"
CSR_FILE="$DIR_NAME"/"$4"


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

if [ -f $CSR_FILE ]
then
    echo "CSR file $CSR_FILE already exists"
    exit 1
fi

echo "Generating CSR : $CSR_FILE"
openssl req -new -key $KEY_FILE -out $CSR_FILE -config $CONFIG_FILE