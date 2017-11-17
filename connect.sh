#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"

. "${BASE_DIR}/.src/commons.sh"

[ -z "$1" ] && @error "Usage: $0 CONFIG_DIR"

config_dir="$1" ; shift
config_path="${BASE_DIR}/${config_dir}"
vpn_file_path="${config_path}/${VPN_FILE_NAME}"
container_name="$(@dockerContainerName ${config_dir})"

[ -d "${config_path}" ] || @error "Invalid CONFIG_DIR: ${config_dir}"
[ -f "${vpn_file_path}" ] || @error "${vpn_file_path} not found"

docker run -it --rm --privileged \
  -l ${CFG_DOCKER_LABEL} \
  -v ${config_path}:/vpn:ro \
  --name ${container_name} \
  --hostname ${container_name} \
  ${CFG_DOCKER_IMG_NAME} ${VPN_FILE_NAME}
