#!/usr/bin/env bash

HOME_DEVELOPER_FF='/home/developer/firefox'
FF_PROFILE="$HOME_DEVELOPER_FF/profile"

sudo chmod 777 $HOME_DEVELOPER_FF
sudo chown developer:developer $HOME_DEVELOPER_FF

if [ ! -d "$FF_PROFILE" ]; then
  firefox -CreateProfile "Developer $FF_PROFILE" >/dev/null 2>&1 &
else
  firefox -new-instance -P "Developer" >/dev/null 2>&1 &
fi
