#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"

. "${BASE_DIR}/.src/commons.sh"

[ -z "$1" ] && @error "Usage: $0 CONFIG_DIR [SSH_PARAMS/SSH_SERVER]"

config_dir="$1" ; shift
config_path="${BASE_DIR}/${config_dir}"

[ -d "${config_path}" ] || @error "Invalid CONFIG_DIR: ${config_dir}"

if [ -z "$*" ] ; then
  @warn "Usage: $0 ${config_dir} SSH_PARAMS/SSH_SERVER"
  if [ -f "${config_path}/ssh/config" ]; then
    @warn "SSH_SERVER:"
    grep -E '^Host\s+[a-zA-Z0-9]' "${config_path}/ssh/config" | sed -E 's/Host\s+/  - /g'
  fi
  exit 1
fi

# Scripts
[ -f "${config_path}/${CFG_SCRIPTS_DIR}/pre-connect.sh" ] && \
  docker exec -it $(@dockerContainerName ${config_dir}) bash -c "${CFG_SCRIPTS_DIR}/pre-connect.sh $*"

docker exec -it $(@dockerContainerName ${config_dir}) ssh "$@"
