#!/usr/bin/env bash


if [ $# -ne 2 ]
then
   echo "Usage:: $0 tmp-dir device-suffix"
   exit 1
fi

DEVICE_TMP_DIR=$1
DEVICE_SUFFIX=$2

#####
# Initialize all the variables
#
. env.sh


#####
# Defensive checks
#
# Make sure the tmp directory does not exist
#
if [ ! -d $DEVICE_TMP_DIR ]
then
    echo "$DEVICE_TMP_DIR does not exist"
    exit 1
fi
#
# Make sure the suffix dir does not exist
#
DEVICE_SUFFIX_DIR=$DEVICE_TMP_DIR/$DEVICE_SUFFIX
if [ -d $DEVICE_SUFFIX_DIR ]
then
    echo "Please remove $DEVICE_SUFFIX_DIR"
    exit 1
fi
#
# CONF FILE
SEED_CONF_FILE=$DEVICE_DIR/$DEVICE_CONF
if [ ! -f $SEED_CONF_FILE ]
then
    echo "Config file $SEED_CONF_FILE does not exist"
    exit 1
fi
#
#
if [ ! -d $SELF_DIR ]
then
    echo "RootCA Directory $SELF_DIR does not exist"
    exit 1
fi
#
SELF_KEY_FILE=$SELF_DIR/$SELF_KEY
if [ ! -f $SELF_KEY_FILE ]
then
    echo "RootCA Key file $SELF_KEY_FILE does not exist"
    exit 1
fi
#
SELF_CRT_FILE=$SELF_DIR/$SELF_CRT
if [ ! -f $SELF_CRT_FILE ]
then
    echo "RootCA CRT file $SELF_CRT_FILE does not exist"
    exit 1
fi


#####


#####
#
# create directory for the device
mkdir $DEVICE_SUFFIX_DIR



####################
#
# Create Key file
#
KEY_FILE=$DEVICE_SUFFIX_DIR/$DEVICE_KEY
#
echo "Generating KEY : $KEY_FILE"
openssl ecparam -out $KEY_FILE -name prime256v1 -genkey
### PREV COMMAND FOR SERVER ## openssl ecparam -name prime256v1 -genkey -out $KEY_FILE
### PREV COMMAND FOR CLIENT (FluentD) ## NOTE : It's on two lines with a backslash
### openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:P-256 -pkeyopt ec_param_enc:named_curve \
###    | openssl pkcs8 -topk8 -nocrypt -outform pem > $KEY_FILE
#
# Convert to DER format
#
DER_FILE=$DEVICE_SUFFIX_DIR/$DEVICE_DER
echo "Converting to DER format : $DER_FILE"
openssl ec -in $KEY_FILE -out $DER_FILE -outform der



####################
#
# Create CSR for the device
#
#####
# Create the conf file
#
DEVICE_COMMON_NAME="$DEVICE_COMMON_NAME_PREFIX"_$DEVICE_SUFFIX
#
CONF_FILE=$DEVICE_SUFFIX_DIR/custom_self.conf
cp $SEED_CONF_FILE $CONF_FILE
echo "organizationName = $DEVICE_ORG_NAME" >> $CONF_FILE
echo "organizationalUnitName = $DEVICE_UNIT_NAME" >> $CONF_FILE
echo "commonName = $DEVICE_COMMON_NAME" >> $CONF_FILE
echo "emailAddress = $DEVICE_EMAIL_ADDRESS" >> $CONF_FILE
#
#
CSR_FILE=$DEVICE_SUFFIX_DIR/$DEVICE_CSR
echo "Generating CSR : $CSR_FILE"
openssl req -new -sha256 -key $KEY_FILE -out $CSR_FILE -config $CONF_FILE



####################
#
# Create the certificate
#
#####
#
CRT_FILE=$DEVICE_SUFFIX_DIR/$DEVICE_CRT
#
echo "Generating CRT : $CRT_FILE"
openssl x509 -req -in $CSR_FILE -sha256 -out $CRT_FILE -outform der -CA $SELF_CRT_FILE -CAkey $SELF_KEY_FILE -CAcreateserial -days 3650
### PREVIOUS COMMAND : openssl x509 -req -in $CSR_FILE -CA $SELF_CRT_FILE -CAkey $SELF_KEY_FILE -CAcreateserial -out $CRT_FILE -days 500 -sha256



