set -e

CFG_DOCKER_IMG_NAME='patagoniantech/vpn'
CFG_DOCKER_LABEL="${CFG_DOCKER_IMG_NAME}"
CFG_DOCKER_HOST_LOCK_VOLUME="/tmp/patagoniantech.vpn.host-lock"
CFG_SCRIPTS_DIR="scripts"
VPN_FILE_NAME="client.ovpn"

# On VPN connect
CFG_SCRIPT_PRE_VPN_CONNECT="pre-vpn-connect.sh"
# On SSH or Browser connect
CFG_SCRIPT_PRE_CONNECT="pre-connect.sh"

@error() {
  echo "# $*" >&2
  exit 1
}

@dockerContainerName() {
  local k="$*"
  k="$(echo "$k" | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/[-]+$//' | sed -E 's/^[-]+//')"
  echo "vpn-$k"
}

# Options

OPTARG_NET=false
OPTARG_PORTS='' #@TODO
while getopts ni::p: opt
do
  case "$opt" in
    n)
      OPTARG_NET=true
      ;;
    p) #@TODO
      [ ! -z "$OPTARG_PORTS" ] && OPTARG_PORTS="$OPTARG_PORTS,"
      OPTARG_PORTS="$OPTARG_PORTS$OPTARG"
      ;;
   \?) echo "ERROR: Invalid option -$OPTARG" >&2
       Error ;;
    :) echo "Missing option argument for -$OPTARG" >&2
       Error ;;
    *) echo "Unimplemented option: -$OPTARG" >&2
       Error ;;
  esac
done
shift $((OPTIND - 1))

if [ ! $IS_BUILD_SCRIPT ]; then
  [ -z "$(docker images -q ${CFG_DOCKER_IMG_NAME})" ] && "${BASE_DIR}/.src/build.sh"

  if [ -z "$1" ]; then
    cat <<EOF
Usage:
  $BASE_SOURCE [-n] CONFIG_DIR[/VPN_FILE_NAME]
      CONFIG_DIR      VPN configuration directory.
      VPN_FILE_NAME   OpenVPN file. Default: client.ovpn
      -n              Connect to system network. Default: No connect VPN to system network.

Examples:
  $BASE_SOURCE arg-prod
  $BASE_SOURCE arg-prod/region2.ovpn
  $BASE_SOURCE arg-qa -net
  $BASE_SOURCE arg-qa/region3.ovpn -net
EOF
    exit 1
  else
    CONFIG_DIR="$1" ; shift
    CONFIG_FULL="$CONFIG_DIR"

    if [[ "$CONFIG_DIR" =~ ^.*/.*$ ]]; then
      VPN_FILE_NAME="$(echo "$CONFIG_DIR" | sed 's/^.*\///')"
      CONFIG_DIR="$(echo "$CONFIG_DIR" | sed 's/\/.*$//')"
    fi

    CONFIG_PATH="${BASE_DIR}/${CONFIG_DIR}"
    [ -d "${CONFIG_PATH}" ] || @error "Invalid CONFIG_DIR: ${CONFIG_DIR}"
    VPNDEV_HOME="${CONFIG_PATH}/.vpndeveloper"
    VPN_FILE_PATH="${CONFIG_PATH}/${VPN_FILE_NAME}"
    CONTAINER_NAME="$(@dockerContainerName "${CONFIG_DIR}_${VPN_FILE_NAME}")"
  fi
fi
