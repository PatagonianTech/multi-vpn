## config_dir
## List configured SSH servers.
##
## Params:
##   config_dir: Configuration directory.

. "${RESOURCES_PATH}/bootstrap.sh"

if [ -f "$SSH_CONFIG_PATH" ]; then
  @print "Current configured SSH Servers list (to use as SSH_SERVER):"
  @print "$(grep -E '^Host\s+[a-zA-Z0-9]' "$SSH_CONFIG_PATH" | sed -E 's/Host\s+/  - /g')"
else
  @error "$SSH_CONFIG_PATH not found"
fi
