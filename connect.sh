#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"

if [ -z "$1" ]; then
  cat <<EOF
Usage:
  $BASE_SOURCE CONFIG_DIR[/VPN_FILE_NAME] [-net]
      CONFIG_DIR      VPN configuration directory
      VPN_FILE_NAME   OpenVPN file. Default: client.ovpn
      -net            If present, connect host network to VPN

Examples:
  $BASE_SOURCE arg-prod
  $BASE_SOURCE arg-prod/region2.ovpn
  $BASE_SOURCE arg-qa -net
  $BASE_SOURCE arg-qa/region3.ovpn -net
EOF

  exit 1
fi

. "${BASE_DIR}/.src/commons.sh"
[ -f "${VPN_FILE_PATH}" ] || @error "${VPN_FILE_PATH} not found"
docker_custom_cfg=''

if [[ "$CONFIG_EXTRA" == *"-net"* ]]; then
  echo "# CONNECTING HOST NETWORK TO VPN..."

  if [ "$(docker ps -a -q --filter volume=${CFG_DOCKER_HOST_LOCK_VOLUME})" ]
    then
      @error "You can connect to onaly one VPN network to host at the same time"
    fi

  sleep 2
  docker_custom_cfg="$docker_custom_cfg --net=host"
  docker_custom_cfg="$docker_custom_cfg -v ${CFG_DOCKER_HOST_LOCK_VOLUME}:/tmp/vpn.host.lock"
fi

file_bash_history="${CONFIG_PATH}/.bash_history"
touch "${file_bash_history}"

# Scripts
[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT}" ] && \
  chmod a+x "${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT}"
[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_VPN_CONNECT}" ] && \
  chmod a+x "${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_VPN_CONNECT}"

set -x

docker run -it --rm --privileged $docker_custom_cfg \
  -v "${CONFIG_PATH}:/vpn:ro" \
  -v "/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket" \
  -v "/home:/home" \
  -v "/mnt:/mnt" \
  -v "$BASE_DIR/.src/run.sh:/run.sh:ro" \
  -v "$BASE_DIR/.src/vpndeveloper.sh:/vpndeveloper.sh:ro" \
  -v "${file_bash_history}:/root/.bash_history" \
  -v "${CONFIG_PATH}/vpndeveloper:/home/vpndeveloper" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e CFG_SCRIPT_PRE_CONNECT=$CFG_SCRIPT_PRE_CONNECT \
  -e CFG_SCRIPT_PRE_VPN_CONNECT=$CFG_SCRIPT_PRE_VPN_CONNECT \
  -e DISPLAY=$DISPLAY \
  --name ${CONTAINER_NAME} \
  --hostname ${CONTAINER_NAME} \
  ${CFG_DOCKER_IMG_NAME} ${VPN_FILE_NAME}
