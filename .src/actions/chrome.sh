## config_dir
## Open Google Chrome browser into VPN connected container.
##
## Params:
##   config_dir: Configuration directory.

# https://github.com/karma-runner/karma-chrome-launcher/issues/83#issuecomment-370755831

. "${RESOURCES_PATH}/bootstrap.sh"

dockerPreConnect "$@"

( set -x
  docker exec -it ${CONTAINER_NAME} su vpndeveloper /vpndeveloper.sh \
    bash -c 'google-chrome-stable --ignore-certificate-errors --disable-gpu'
)
