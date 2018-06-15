## {docker build params}
## Build Docker image.
##
## Params:
##   {docker build params}: `docker build` parameters.

cd "${BX_RESOURCES_PATH}"

docker build \
  -t ${CFG_DOCKER_IMG_NAME} \
  --build-arg HOST_USER=$(id -u) \
  --build-arg HOST_GROUP=$(id -g) \
  "$@" \
  .
