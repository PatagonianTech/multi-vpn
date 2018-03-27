#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
. "${BASE_DIR}/.src/commons.sh"

# Usage
if [ -z "$1" ] ; then
  err_msg="Usage:
    $BASE_SOURCE $CONFIG_FULL [SSH_PARAMS] [SSH_SERVER]
        SSH_PARAMS   Parameters to use in 'ssh' command.
        SSH_SERVER   SSH Parameters and SSH Server to connect.
                     Skip it to see a SSH Servers list.
  "

  if [ -f "$CONFIG_PATH/ssh/config" ]; then
    err_msg="$err_msg

Current configured SSH Servers list (to use as SSH_SERVER):
$(grep -E '^Host\s+[a-zA-Z0-9]' "$CONFIG_PATH/ssh/config" | sed -E 's/Host\s+/  - /g')
"
  fi

  echo "$err_msg"
  exit 2
fi

# Main
[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT}" ] && \
  docker exec -it ${CONTAINER_NAME} bash -c "${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT} $*"

set -x
docker exec -it ${CONTAINER_NAME} ssh "$@"
