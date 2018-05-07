#!/usr/bin/env bash

set -e

if [ -d /vpn/ssh ]; then
  prepare_ssh() {
    local ug="$1"
    local p="$2/.ssh"
    [ -d "${p}" ] && rm -rf "${p}"
    mkdir "${p}"
    cp -r /vpn/ssh/* "${p}"
    chown -R ${ug} "${p}"
    chmod -R 600 "${p}"
    chmod 700 "${p}"
  }

  prepare_ssh 0:0 $HOME

  chown -R vpndeveloper:vpndeveloper ${VPNDEV_HOME}
  chmod 777 ${VPNDEV_HOME}
  prepare_ssh vpndeveloper:vpndeveloper $VPNDEV_HOME
fi

set -x

[ -f /vpn/scripts/$CFG_SCRIPT_PRE_VPN_CONNECT ] && /vpn/scripts/$CFG_SCRIPT_PRE_VPN_CONNECT

openvpn --config $1
