#!/usr/bin/env bash




########################################
# Set all the variables needed
###

# For creating self signed certificate authority
SELF_DIR="self"
SELF_KEY="self.key"
SELF_CRT="self.crt"
SELF_CONF="self.conf"

# For creating server key and cert
SERVER_DIR="server"
SERVER_KEY="server.key"
SERVER_CSR="server.csr"
SERVER_CRT="server.crt"
SERVER_CONF="server.conf"

# For creating device keys and certs
DEVICE_DIR="device"
DEVICE_KEY="device.key"
DEVICE_CSR="device.csr"
DEVICE_CRT="device.crt"
DEVICE_CONF="device.conf"

# For creating configuration file that will be used to create CSR
#
# If the Org information is same across all - it's easier to set it once
# If diiferent names are needed, set them individually below
ALL_ORG_NAME="ARM Inc"
ALL_UNIT_NAME="ISG"
ALL_EMAIL_ADDRESS='isg@arm.com'
#
# For self signed certificate authority
SELF_ORG_NAME=$ALL_ORG_NAME
SELF_UNIT_NAME=$ALL_UNIT_NAME
SELF_EMAIL_ADDRESS=$ALL_EMAIL_ADDRESS
SELF_COMMON_NAME='mqttSelf'
#
# For server
SERVER_ORG_NAME=$ALL_ORG_NAME
SERVER_UNIT_NAME=$ALL_UNIT_NAME
SERVER_EMAIL_ADDRESS=$ALL_EMAIL_ADDRESS
SERVER_COMMON_NAME='ingest.mqtt.data.mbedcloudintegration.net'
#
# For Devices
DEVICE_ORG_NAME=$ALL_ORG_NAME
DEVICE_UNIT_NAME=$ALL_UNIT_NAME
DEVICE_EMAIL_ADDRESS=$ALL_EMAIL_ADDRESS
DEVICE_COMMON_NAME_PREFIX='device'
########################################



