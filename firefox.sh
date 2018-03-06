#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
. "${BASE_DIR}/.src/commons.sh"

[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT}" ] && \
  docker exec -it ${CONTAINER_NAME} bash -c "${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT} $*"

set -x
docker exec -it ${CONTAINER_NAME} su vpndeveloper /vpndeveloper.sh firefox
