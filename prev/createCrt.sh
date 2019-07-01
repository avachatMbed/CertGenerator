#!/usr/bin/env bash


if [ $# -ne 6 ]
then
   echo "Usage $0 self_dirName self_key_file_name self_crt_file_name crt_dir_name csr_file_name crt_file_name"
   exit 1
fi

SELF_DIR_NAME=$1
SELF_KEY_FILE="$SELF_DIR_NAME"/"$2"
SELF_CRT_FILE="$SELF_DIR_NAME"/"$3"

CRT_DIR_NAME=$4
CSR_FILE="$CRT_DIR_NAME"/"$5"
CRT_FILE="$CRT_DIR_NAME"/"$6"


if [ ! -d $SELF_DIR_NAME ]
then
    echo "RootCA Directory $SELF_DIR_NAME does not exist"
    exit 1
fi

if [ ! -f $SELF_KEY_FILE ]
then
    echo "RootCA Key file $SELF_KEY_FILE does not exist"
    exit 1
fi

if [ ! -f $SELF_CRT_FILE ]
then
    echo "RootCA CRT file $SELF_CRT_FILE does not exist"
    exit 1
fi



if [ ! -d $CRT_DIR_NAME ]
then
    echo "CRT Directory $CRT_DIR_NAME does not exist"
    exit 1
fi

if [ ! -f $CSR_FILE ]
then
    echo "CSR file $CSR_FILE does not exist"
    exit 1
fi

if [ -f $CRT_FILE ]
then
    echo "CRT file $CRT_FILE already exists"
    exit 1
fi

echo "Generating CRT : $CRT_FILE"
openssl x509 -req -in $CSR_FILE -CA $SELF_CRT_FILE -CAkey $SELF_KEY_FILE -CAcreateserial -out $CRT_FILE -days 500 -sha256