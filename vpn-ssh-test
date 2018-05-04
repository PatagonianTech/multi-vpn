#!/usr/bin/env bash

BASE_SOURCE="$0"
BASE_DIR="$(cd "$(dirname "$BASE_SOURCE")" ; pwd)"
. "${BASE_DIR}/.src/commons.sh"


if [ -f "$CONFIG_PATH/ssh/config" ]; then
  configs=($(grep -E '^Host\s+[a-zA-Z0-9]' "$CONFIG_PATH/ssh/config" | sed -E 's/Host\s+//g'))

  if [ -z "$configs" ]; then
    @error "$CONFIG_PATH/ssh/config > Hosts not found"
  else
    sep='# ============================================================================='
    ctotal=0
    cok=0

    for c in ${configs[@]}; do
      ctotal=$((ctotal+1))

      echo $sep
      echo "# Progress: $ctotal of ${#configs[@]}..."

      (
        # Test
        set -x
        docker exec -it ${CONTAINER_NAME} \
          ssh $c echo "Connected to \$(id -un)@$c"
      ) && {
        # Ok
        cok=$((cok+1))
        echo
        echo '# OK'
      } || {
        # Error
        echo
        echo '# ERROR'
      }
    done

    echo $sep
    echo
    echo "Result: $cok connected of $ctotal"
  fi
else
  @error "$CONFIG_PATH/ssh/config not defined"
fi
