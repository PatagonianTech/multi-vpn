## config_dir
## Verify SSH connection into VPN connected container.
##
## Params:
##   config_dir: Configuration directory.

@Actions.ssh-exec "$1" echo "Connected to \$(id -un)"
