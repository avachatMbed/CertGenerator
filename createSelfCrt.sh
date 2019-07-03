#!/usr/bin/env bash

if [ $# -ne 0 ]
then
   echo "Usage:: $0 <use env.sh to set the parameters>"
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
if [ ! -f $KEY_FILE ]
then
    echo "Key file $KEY_FILE does not exist"
    exit 1
fi

# CONF FILE
SEED_CONF_FILE=$SELF_DIR/$SELF_CONF
if [ ! -f $SEED_CONF_FILE ]
then
    echo "Config file $SEED_CONF_FILE does not exist"
    exit 1
fi

# CRT file
CRT_FILE=$SELF_DIR/$SELF_CRT
if [ -f $CRT_FILE ]
then
    echo "CRT file $CRT_FILE already exists"
    exit 1
fi

#####


#####
# Create the tmp dir if needed
#
TMP_DIR=$SELF_DIR/tmp
mkdir -p $TMP_DIR

#####
# Create the conf file
#
CONF_FILE=$TMP_DIR/custom_self.conf
cp $SEED_CONF_FILE $CONF_FILE
echo "organizationName = $SELF_ORG_NAME" >> $CONF_FILE
echo "organizationalUnitName = $SELF_UNIT_NAME" >> $CONF_FILE
echo "commonName = $SELF_COMMON_NAME" >> $CONF_FILE
echo "emailAddress = $SELF_EMAIL_ADDRESS" >> $CONF_FILE


echo "Generating CRT : $CRT_FILE"
openssl req -x509 -new -nodes -key $KEY_FILE -sha256 -days 12775 -config $CONF_FILE -out $CRT_FILE
## For reference, the command from Device Management documentation is below
## openssl req -key CA_private.pem -new -sha256 -x509 -days 12775 -out CA_cert.pem -config ca.cnf -extensions ext

