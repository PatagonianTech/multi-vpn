#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
. "${BASE_DIR}/.src/commons.sh"

[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT}" ] && \
  docker exec -it ${CONTAINER_NAME} bash -c "${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT} $*"

set -x
# https://github.com/karma-runner/karma-chrome-launcher/issues/83#issuecomment-370755831
docker exec -it ${CONTAINER_NAME} su vpndeveloper /vpndeveloper.sh bash -c 'google-chrome-stable --ignore-certificate-errors --disable-gpu'
