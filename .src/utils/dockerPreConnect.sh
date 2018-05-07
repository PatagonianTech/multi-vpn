## *
## Run Docker pre-connect into Conteiner.
##
## Params:
##   *: All script arguments

[ -f "${CONFIG_PATH}/${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT}" ] && \
  docker exec -it ${CONTAINER_NAME} bash -c \
    "${CFG_SCRIPTS_DIR}/${CFG_SCRIPT_PRE_CONNECT} \"$@\""
