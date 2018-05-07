## config_dir scp_arguments*
## Connect to VPN connected container.
##
## Params:
##   config_dir:     Configuration directory.
##   scp_arguments*: Arguments to use in 'scp' command.

. "${RESOURCES_PATH}/bootstrap.sh"

dockerPreConnect "$@"

( set -x
  docker exec -it ${CONTAINER_NAME} su vpndeveloper /scp.sh "$(pwd)" "$@"
)
