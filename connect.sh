#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"

. "${BASE_DIR}/.src/commons.sh"

[ -z "$1" ] && @error "Usage: $0 CONFIG_DIR [-net]"

config_dir="$1" ; shift
config_extra="$@"
config_path="${BASE_DIR}/${config_dir}"
vpn_file_path="${config_path}/${VPN_FILE_NAME}"
container_name="$(@dockerContainerName ${config_dir})"
docker_custom_cfg=''

[ -d "${config_path}" ] || @error "Invalid CONFIG_DIR: ${config_dir}"
[ -f "${vpn_file_path}" ] || @error "${vpn_file_path} not found"

if [[ "$config_extra" == *"-net"* ]]; then
  echo "# CONNECTING HOST NETWORK TO VPN..."

  if [ "$(docker ps -a -q --filter volume=${CFG_DOCKER_HOST_LOCK_VOLUME})" ]
    then
      @error "You can connect to onaly one VPN network to host at the same time"
    fi

  sleep 2
  docker_custom_cfg="$docker_custom_cfg --net=host"
  docker_custom_cfg="$docker_custom_cfg -v ${CFG_DOCKER_HOST_LOCK_VOLUME}:/tmp/vpn.host.lock"
fi

file_bash_history="${config_path}/.bash_history"
touch "${file_bash_history}"

docker run -it --rm --privileged $docker_custom_cfg \
  -v "${config_path}:/vpn:ro" \
  -v "/home:/home" \
  -v "/mnt:/mnt" \
  -v "${file_bash_history}:/root/.bash_history" \
  --name ${container_name} \
  --hostname ${container_name} \
  ${CFG_DOCKER_IMG_NAME} ${VPN_FILE_NAME}
