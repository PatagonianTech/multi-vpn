# Import this file.

OPTARG_NET=false
OPTARG_PORTS='' #@TODO
while getopts ni::p: opt
do
  case "$opt" in
    n) OPTARG_NET=true ;;
    p) #@TODO
      [ ! -z "$OPTARG_PORTS" ] && OPTARG_PORTS="$OPTARG_PORTS,"
      OPTARG_PORTS="$OPTARG_PORTS$OPTARG"
      ;;
   \?) @error "ERROR: Invalid option -$OPTARG" ;;
    :) @error "Missing option argument for -$OPTARG" ;;
    *) @error "Unimplemented option: -$OPTARG" ;;
  esac
done
shift $((OPTIND - 1))

[ -z "$(docker images -q ${CFG_DOCKER_IMG_NAME})" ] && @Actions.build

CONFIG_DIR="$1" ; shift ; CONFIG_DIR="${CONFIG_DIR%/}" ; CONFIG_DIR="${CONFIG_DIR#./}"
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
SSH_CONFIG_PATH="$CONFIG_PATH/ssh/config"

# Enable logs
set -x
