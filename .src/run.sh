#!/usr/bin/env bash

if [ ! -d $HOME/.ssh ] && [ -d /vpn/ssh ] ; then
  cp -r /vpn/ssh $HOME/.ssh
  chown -R 0:0 $HOME/.ssh
  chmod -R 600 $HOME/.ssh
  chmod 700 $HOME/.ssh
fi

set -x

openvpn --config $1
