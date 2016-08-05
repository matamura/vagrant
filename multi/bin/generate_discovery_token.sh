#!/bin/bash

CURRENT_DIR=`dirname $0`
CLUSTER_SIZE=${1:-3}
TOKEN_URL=`curl -w "\n" "https://discovery.etcd.io/new?size=${CLUSTER_SIZE}"`
CLOUD_CONFIG_DIR=${CURRENT_DIR}/../roles/etcd/template

sed -e "s#__discovery_token_url__#${TOKEN_URL}#g" ${CLOUD_CONFIG_DIR}/cloud-config.yml.j2 > /tmp/cloud-config.yml.etcd.j2

