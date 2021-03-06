## config_dir
## Connect to VPN.
##
## Params:
##   config_dir: Configuration directory.
##
## Args:
##   -n  Connect host network to VPN.

# Pre
[ -f "${VPN_FILE_PATH}" ] || @error "${VPN_FILE_PATH} not found"
docker_custom_cfg=''

if ${OPTARG_NET}; then
  @print "CONNECTING HOST NETWORK TO VPN..."

  [ "$(docker ps -a -q --filter volume=${CFG_DOCKER_HOST_LOCK_VOLUME})" ] && \
    @error "You can connect to onaly one VPN network to host at the same time"

  sleep 2
  docker_custom_cfg="${docker_custom_cfg} --net=host"
  docker_custom_cfg="${docker_custom_cfg} -v ${CFG_DOCKER_HOST_LOCK_VOLUME}:/tmp/vpn.host.lock"
fi

# Root history
file_bash_history="${CONFIG_PATH}/.bash_history"
touch "${file_bash_history}"

dockerPreConnect "$@"

[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_VPN_CONNECT}" ] && \
  chmod a+x "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_VPN_CONNECT}"

# Main

( set -x
  docker run -it --rm --privileged ${docker_custom_cfg} \
    -v "${CONFIG_PATH}:/vpn:ro" \
    -v "/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket" \
    -v "/home:/home" \
    -v "/mnt:/mnt" \
    -v "/media:/media" \
    -v "${BX_RESOURCES_PATH}/run.sh:/run.sh:ro" \
    -v "${BX_RESOURCES_PATH}/scp.sh:/scp.sh:ro" \
    -v "${BX_RESOURCES_PATH}/vpndeveloper.sh:/vpndeveloper.sh:ro" \
    -v "${file_bash_history}:/root/.bash_history" \
    -v "${VPNDEV_HOME}:/opt/vpndeveloper" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e CFG_SCRIPT_PRE_CONNECT=${CFG_SCRIPT_PRE_CONNECT} \
    -e CFG_SCRIPT_PRE_VPN_CONNECT=${CFG_SCRIPT_PRE_VPN_CONNECT} \
    -e DISPLAY=$DISPLAY \
    --name ${CONTAINER_NAME} \
    --hostname ${CONTAINER_NAME} \
    ${CFG_DOCKER_IMG_NAME} ${VPN_FILE_NAME}
)
