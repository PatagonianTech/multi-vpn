## config_dir [ssh_arguments]
## Verify SSH connection into VPN connected container.
##
## config_dir: Configuration directory.

. "${RESOURCES_PATH}/bootstrap.sh"

if [ -f "$SSH_CONFIG_PATH" ]; then
  configs=($(grep -E '^Host\s+[a-zA-Z0-9]' "$SSH_CONFIG_PATH" | sed -E 's/Host\s+//g'))

  if [ -z "$configs" ]; then
    @error "$SSH_CONFIG_PATH > Hosts not found"
  else
    ctotal=0
    cok=0

    for c in ${configs[@]}; do
      ctotal=$((ctotal+1))

      @print-colorized-line-char
      @print "# Progress: $ctotal of ${#configs[@]}..."

      (
        # Test
        set -x
        docker exec -it ${CONTAINER_NAME} \
          ssh $c echo "Connected to \$(id -un)@$c"
      ) && {
        # Ok
        cok=$((cok+1))
        @print
        @print '# OK'
      } || {
        # Error
        @print
        @print '# ERROR'
      }
    done

    @print-colorized-line-char
    @print
    @print "Result: $cok connected of $ctotal"
  fi
else
  @error "$SSH_CONFIG_PATH not defined"
fi
