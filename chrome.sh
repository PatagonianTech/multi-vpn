#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"

. "${BASE_DIR}/.src/commons.sh"

[ -z "$1" ] && @error "Usage: $0 CONFIG_DIR"

config_dir="$1" ; shift
config_path="${BASE_DIR}/${config_dir}"

[ -d "${config_path}" ] || @error "Invalid CONFIG_DIR: ${config_dir}"


# Scripts
[ -f "${config_path}/${CFG_SCRIPTS_DIR}/pre-connect.sh" ] && \
  docker exec -it $(@dockerContainerName ${config_dir}) bash -c "${CFG_SCRIPTS_DIR}/pre-connect.sh $*"

docker exec -it $(@dockerContainerName ${config_dir}) su vpndeveloper /vpndeveloper.sh google-chrome-stable
