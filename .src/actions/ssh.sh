## config_dir ssh_arguments*
## Connect to VPN connected container.
##
## Params:
##   config_dir:     Configuration directory.
##   ssh_arguments*: Arguments to use in 'ssh' command.

. "${RESOURCES_PATH}/bootstrap.sh"

dockerPreConnect "$@"

@cmd-log docker exec -it ${CONTAINER_NAME} ssh "$@"
