#!/usr/bin/env bash

set -e
WORKING_DIR="$1" ; shift

set -x

cd "$WORKING_DIR"
scp "$@"
