#!/usr/bin/env bash


########################################
#
# #################
# README
# -----------------
#
# This file goes through ALL the steps needed to create
# 1. RootCA (Key, certificate) for self signing
# 2. Server : Server key, CSR and certificate signed with the root above
# 3. Client : Client key, CSR and certificate signed with the root above
#
#
#
# #################
# Required set up
# -----------------
# The three directories needed for self, server, client should exist
# They should contain the config needed for creating the CSR and the certificate
# Their names should be set in the following vars (default values provided)
#
#
# #################
# Running
# -----------------
# While running you will be prompted for the password.
# With this password the self key will be generated.
# The same password will be required for creating the certificates.
#
#
########################################



########################################
# Set all the variables needed
###
SELF_DIR="self"
SELF_KEY="self.key"
SELF_CRT="self.crt"
SELF_CONF="self.conf"

SERVER_DIR="server"
SERVER_KEY="server.key"
SERVER_CSR="server.csr"
SERVER_CRT="server.crt"
SERVER_CONF="server.conf"

CLIENT_DIR="client"
CLIENT_KEY="client.key"
CLIENT_CSR="client.csr"
CLIENT_CRT="client.crt"
CLIENT_CONF="client.conf"
########################################


########################################
# Run all the commands now
###
./createSelfKey.sh $SELF_DIR $SELF_KEY
./createSelfCrt.sh $SELF_DIR $SELF_KEY $SELF_CONF $SELF_CRT

./createKey.sh $SERVER_DIR server $SERVER_KEY
./createCSR.sh $SERVER_DIR $SERVER_KEY $SERVER_CONF $SERVER_CSR
./createCrt.sh $SELF_DIR $SELF_KEY $SELF_CRT $SERVER_DIR $SERVER_CSR $SERVER_CRT

./createKey.sh $CLIENT_DIR client $CLIENT_KEY
./createCSR.sh $CLIENT_DIR $CLIENT_KEY $CLIENT_CONF $CLIENT_CSR
./createCrt.sh $SELF_DIR $SELF_KEY $SELF_CRT $CLIENT_DIR $CLIENT_CSR $CLIENT_CRT
