#!/bin/bash

ABSPATH=`readlink -f $0`
DIRPATH=`dirname $ABSPATH`
cd ${DIRPATH}

### Load conf/config.ini configuration file ###
source <(grep = config.ini)

function log() {
  timestamp=`date "+%Y-%m-%d %H:%M:%S"`
  echo "[${USER}][${timestamp}][${1}]: ${2}"
}

main() {
  log "INFO" "Installing ${SERVICE_NAME}"
  
  host_arch=$(uname -m)
  if [[ ${host_arch} == "aarch64" ]]; then
    app_arch="arm64"
  elif [[ ${host_arch} == "x86_64" ]]; then
    app_arch="amd64"
  fi

  sudo cp ${SERVICE_PATH}/k9s_linux_${app_arch} /usr/local/bin/${SERVICE_NAME}

}

main "$@"
