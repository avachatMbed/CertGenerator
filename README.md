# CertGenerator


-----------------
Required set up
-----------------
The three directories needed for `self`, `server`, `device` should exist.
They should contain the config needed for creating the CSR and the certificate.
**NOTE** The above will automatically exist if you clone this repo.


-----------------
Setting up parameters used for creating the certificates
-----------------
```
$ vi ./env.sh
```
Edit the file to set the values needed by the scripts.
Defaults are provided.


-----------------
Running
-----------------
While running you will be prompted for the password.
With this password the self key will be generated.
The same password will be required for creating the certificates.

Creating private key for self signing authority
```
./createSelfKey.sh
```
Createing root certificate for self signing autority
```
./createSelfCrt.sh
```

Creating keys and certificates for multiple devices
```
./createMultipleDeviceCerts.sh <num-devices>
#
# This will create a devices/tmp dir and within it subdirs for every device
# such as device/tmp/1 and each subdir will contain the device key and certificate
```

-----------------
NOTE
-----------------
The 'tmp' sub directory that's created by the scripts is added to .gitignore file.
The keys are generated with '.key' extension and '*.key' is also added to the .gitignore file.
The certs are generated with '.crt' extension and '*.crt' is also added to the .gitignore file.
