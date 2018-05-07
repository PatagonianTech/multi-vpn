## config_dir
## Open Firefox browser into VPN connected container.
##
## Params:
##   config_dir: Configuration directory.

. "${RESOURCES_PATH}/bootstrap.sh"

dockerPreConnect "$@"

set -x
  docker exec -it ${CONTAINER_NAME} su vpndeveloper /vpndeveloper.sh \
    firefox
set +x
