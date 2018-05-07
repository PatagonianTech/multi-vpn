## config_dir command*
## Execute command on every configured server at VPN connected container.
##
## Params:
##   config_dir: Configuration directory.
##   command*:   Command to execute.

. "${RESOURCES_PATH}/bootstrap.sh"
local command="$@"

[ ! -z "$command" ] || @error 'command* is required'

if [ -f "$SSH_CONFIG_PATH" ]; then
  local configs=($(sshServersList))

  if [ -z "$configs" ]; then
    @error "$SSH_CONFIG_PATH > Hosts not found"
  else
    ctotal=0
    cok=0

    for c in ${configs[@]}; do
      ctotal=$((ctotal+1))

      @print-line 120 '#'
      @print "Progress: $ctotal of ${#configs[@]}..."

      (
        # Test
        set -x
        docker exec -it ${CONTAINER_NAME} ssh $c "$command"
      ) && {
        # Ok
        cok=$((cok+1))
        @print
        @print 'OK'
      } || {
        # Error
        @print
        @print 'ERROR'
      }
    done

    @print-line 120 '#'
    @print
    @print "Result: $cok connected of $ctotal"
  fi
else
  @error "$SSH_CONFIG_PATH not defined"
fi
