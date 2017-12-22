#!/usr/bin/env bash

HOME_DEVELOPER='/home/vpndeveloper'
LOGS_FILE="$HOME_DEVELOPER/vpndeveloper-exec-$1.log"

sudo chmod 777 $HOME_DEVELOPER
sudo chown vpndeveloper:vpndeveloper $HOME_DEVELOPER

$@ >$LOGS_FILE 2>&1 &
echo "Logs: $LOGS_FILE"
