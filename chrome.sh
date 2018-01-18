#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
. "${BASE_DIR}/.src/commons.sh"

# Scripts
[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/pre-connect.sh" ] && \
  docker exec -it ${CONTAINER_NAME} bash -c "${CFG_SCRIPTS_DIR}/pre-connect.sh $*"

docker exec -it ${CONTAINER_NAME} su vpndeveloper /vpndeveloper.sh google-chrome-stable
