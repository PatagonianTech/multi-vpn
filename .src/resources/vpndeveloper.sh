#!/usr/bin/env bash

#https://github.com/jupyter/notebook/issues/2836
export BROWSER=google-chrome
export LOGS_FILE="${VPNDEV_HOME}/vpndeveloper-exec-$1.log"

"$@" >$LOGS_FILE 2>&1 &
echo "Logs: $LOGS_FILE"
