#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
IS_BUILD_SCRIPT=true

. "${BASE_DIR}/commons.sh"

( cd "$BASE_DIR"
  docker build \
    -t ${CFG_DOCKER_IMG_NAME} \
    --build-arg HOST_USER=$(id -u) \
    --build-arg HOST_GROUP=$(id -g) \
    .
)
