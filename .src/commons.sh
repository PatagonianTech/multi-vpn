CFG_DOCKER_IMG_NAME='reduardo7/vpn'
CFG_DOCKER_LABEL="${CFG_DOCKER_IMG_NAME}"
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
  echo "vpn-${k}"
}
