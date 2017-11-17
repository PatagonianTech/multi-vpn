#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"

. "${BASE_DIR}/.src/commons.sh"

[ -z "$1" ] && @error "Usage: $0 CONFIG_DIR"

config_dir="$1" ; shift
config_path="${BASE_DIR}/${config_dir}"

[ -d "${config_path}" ] || @error "Invalid CONFIG_DIR: ${config_dir}"

docker exec -it $(@dockerContainerName ${config_dir}) bash
