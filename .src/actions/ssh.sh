## config_dir ssh_arguments*
## Connect to VPN connected container.
##
## config_dir:     Configuration directory.
## ssh_arguments*: Arguments to use in 'ssh' command.

. "${RESOURCES_PATH}/bootstrap.sh"

@dockerPreConnect

set -x
docker exec -it ${CONTAINER_NAME} ssh "$@"
