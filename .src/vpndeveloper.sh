#!/usr/bin/env bash

#https://github.com/jupyter/notebook/issues/2836
export BROWSER=google-chrome

export HOME_DEVELOPER='/home/vpndeveloper'
export LOGS_FILE="$HOME_DEVELOPER/vpndeveloper-exec-$1.log"

sudo chmod 777 $HOME_DEVELOPER
sudo chown vpndeveloper:vpndeveloper $HOME_DEVELOPER

$@ >$LOGS_FILE 2>&1 &
echo "Logs: $LOGS_FILE"
