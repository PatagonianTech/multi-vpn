CFG_DOCKER_IMG_NAME='patagoniantech/vpn'
CFG_DOCKER_LABEL="${CFG_DOCKER_IMG_NAME}"
CFG_DOCKER_HOST_LOCK_VOLUME="/tmp/patagoniantech.vpn.host-lock"
VPN_FILE_NAME='client.ovpn'

@warn() {
  echo "# $*" >&2
}

@error() {
  @warn "$*"
  exit 1
}

@dockerContainerName() {
  local k="$*"
  k="$(echo "$k" | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/[-]+$//' | sed -E 's/^[-]+//')"
  echo "vpn-$k"
}

[ ! $IS_BUILD_SCRIPT ] && \
  [ -z "$(docker images -q ${CFG_DOCKER_IMG_NAME})" ] && \
  "${BASE_DIR}/.src/build.sh"
