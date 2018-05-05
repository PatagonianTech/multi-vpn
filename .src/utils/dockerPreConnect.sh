## *
## Run Docker pre-connect into Conteiner.

[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT}" ] && \
  docker exec -it ${CONTAINER_NAME} bash -c "${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT} $*"
