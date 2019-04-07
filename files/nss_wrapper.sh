#!/bin/sh

# export environment to use with nss_wrapper
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /go/passwd.template > /tmp/passwd
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/etc/group

