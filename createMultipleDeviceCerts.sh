#!/bin/bash


if [ $# -ne 1 ]
then
   echo "Usage:: $0 num-devices"
   exit 1
fi

NUM_DEVICES=$1

#####
# Initialize all the variables
#
. env.sh



#####
# Defensive checks
if [ ! -d $DEVICE_DIR ]
then
    echo "Directory $DEVICE_DIR does not exist"
    exit 1
fi

#####
# Make sure the tmp directory does not exist
#
DEVICE_TMP_DIR=$DEVICE_DIR/tmp
if [ -d $DEVICE_TMP_DIR ]
then
    echo "Please remove the $DEVICE_TMP_DIR"
    exit 1
fi
#
# Create a brand new tmp dir
mkdir $DEVICE_TMP_DIR


for i in `seq 1 $NUM_DEVICES`
do
    ./createDeviceKeyCerts.sh $DEVICE_TMP_DIR $i
done

