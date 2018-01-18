#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
. "${BASE_DIR}/.src/commons.sh"

docker exec -it ${CONTAINER_NAME} bash
