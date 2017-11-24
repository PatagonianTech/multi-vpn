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
  if [ "$(docker ps -a -q --filter volume=${CFG_DOCKER_HOST_LOCK_VOLUME})" ]
    then
      @error "You can connect to onaly one VPN network to host at the same time"
    fi

  docker_custom_cfg="$docker_custom_cfg --net=host"
  docker_custom_cfg="$docker_custom_cfg -v ${CFG_DOCKER_HOST_LOCK_VOLUME}:/tmp/vpn.host.lock"
fi

docker run -it --rm --privileged $docker_custom_cfg \
  -v "${config_path}:/vpn:ro" \
  -v "${HOME}:/home/${USER}" \
  --name ${container_name} \
  --hostname ${container_name} \
  ${CFG_DOCKER_IMG_NAME} ${VPN_FILE_NAME}
