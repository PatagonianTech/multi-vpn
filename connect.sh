#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"

. "${BASE_DIR}/.src/commons.sh"

[ -z "$1" ] && @error "Usage: $0 CONFIG_DIR [LOCAL_PORT_1:REMOTE_PORT_1 [LOCAL_PORT_N:REMOTE_PORT_N]]"

config_dir="$1" ; shift
config_path="${BASE_DIR}/${config_dir}"
vpn_file_path="${config_path}/${VPN_FILE_NAME}"
container_name="$(@dockerContainerName ${config_dir})"
docker_ports=''

[ -f "${vpn_file_path}" ] || @error "${vpn_file_path} not found"

# Ports
if [ ! -z "$@" ]; then
  for p in "$@"; do
    docker_ports="$docker_ports -p $p"
  done
fi

# Create container
docker run -it --rm --privileged $docker_ports \
  -l ${CFG_DOCKER_LABEL} \
  -v ${config_path}:/vpn:ro \
  --name ${container_name} \
  --hostname ${container_name} \
  ${CFG_DOCKER_IMG_NAME} ${VPN_FILE_NAME}
