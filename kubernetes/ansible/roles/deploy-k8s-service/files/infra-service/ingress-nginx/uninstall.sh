#!/bin/bash

ABSPATH=`readlink -f $0`
DIRPATH=`dirname $ABSPATH`
cd ${DIRPATH}

### Load conf/config.ini configuration file ###
source <(grep = config.ini)

## log levels: DEBUG,INFO,WARN,ERROR,FATAL ##
function log() {
  timestamp=`date "+%Y-%m-%d %H:%M:%S"`
  echo "[${USER}][${timestamp}][${1}]: ${2}"
}

main() {

  log "INFO" "### Uninstalling ${SERVICE_NAME} Service ###"
  helm status ${SERVICE_NAME} -n ${SERVICE_NAMESPACE} > /dev/null 2>&1
  ret_val=$?
  if [[ ${ret_val} != 0 ]]; then
    log "ERROR" "The ${SERVICE_NAME} service doesn't exist"
    exit 1
  fi

  msg=$(helm uninstall ${SERVICE_NAME} -n ${SERVICE_NAMESPACE})
  ret_val=$?
  if [[ ${ret_val} != 0 ]]; then
    log "ERROR" "Failed to uninstall..."
    exit 2
  fi
  log "INFO" "${msg}"
}

main "$@"