## config_dir
## Connect to VPN connected container.
##
## Params:
##   config_dir: Configuration directory.

( set -x
  docker exec -it ${CONTAINER_NAME} su vpndeveloper
)
