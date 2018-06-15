## config_dir ssh_arguments*
## Connect to VPN connected container.
## Exec "list" to show configured servers.
##
## Params:
##   config_dir:     Configuration directory.
##   ssh_arguments*: Arguments to use in 'ssh' command.

dockerPreConnect "$@"

( set -x
  docker exec -it ${CONTAINER_NAME} ssh "$@"
)
