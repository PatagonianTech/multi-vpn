#!/usr/bin/env bash

FF_PROFILE='/home/developer/firefox/profile'

if [ ! -d "$FF_PROFILE" ]; then
  firefox -CreateProfile "Developer $FF_PROFILE" >/dev/null 2>&1 &
else
  firefox -new-instance -P "Developer" >/dev/null 2>&1 &
fi
