## config_dir
## List configured SSH servers.
##
## Params:
##   config_dir: Configuration directory.

. "${RESOURCES_PATH}/bootstrap.sh"

if [ -f "$SSH_CONFIG_PATH" ]; then
  local configs=($(sshServersList))
  @print "Current configured SSH Servers list (to use as SSH_SERVER):"

  for c in ${configs[@]}; do
    @print "  - $c"
  done
else
  @error "$SSH_CONFIG_PATH not found"
fi
