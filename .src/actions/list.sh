## config_dir
## List configured SSH servers.
## Use with 'ssh'.
##
## Params:
##   config_dir: Configuration directory.

if [ -f "${SSH_CONFIG_PATH}" ]; then
  local configs=($(sshServersList))
  @print "Current configured SSH Servers list (to use as SSH_SERVER):"

  for c in ${configs[@]}; do
    @print "  - $(@style color:green)$c"
  done
else
  @error "${SSH_CONFIG_PATH} not found"
fi
