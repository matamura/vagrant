#!/bin/bash

CLOUD_CONFIG_DIR=${1:-/usr/share/oem}
TARGET_CONFIG_FILE=${CLOUD_CONFIG_DIR}/${2:-cloud-config.yml}
PRIVATE_IPADDR=$3
PUBLIC_IPADDR=$3
HOSTNAME=`hostname`

sed -i -e "s#\$private_ipv4#${PRIVATE_IPADDR}#g" ${TARGET_CONFIG_FILE}
sed -i -e "s#\$public_ipv4#${PUBLIC_IPADDR}#g" ${TARGET_CONFIG_FILE}
sed -i -e "s#__hostname__#${HOSTNAME}#g" ${TARGET_CONFIG_FILE}

