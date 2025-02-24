#!/bin/sh

# Be verbose and stop if there is a failure
set -euxo pipefail

echo "Configuration is..."
echo "LOCKS_AUTH = $LOCKS_AUTH"
echo "STORAGE_PATH_SHARED = $STORAGE_PATH_SHARED"
echo "STORAGE_PATH_PROMETHEUS = $STORAGE_PATH_PROMETHEUS"
echo "STORAGE_PATH_ACL = $STORAGE_PATH_ACL"
echo "PYWB_IMAGE = $PYWB_IMAGE"
echo "EXTRA_CONFIG = $EXTRA_CONFIG"
echo "DLS_ACCESS_SERVER = $DLS_ACCESS_SERVER"
echo "UKWA_INDEX = $UKWA_INDEX"
echo "UKWA_ARCHIVE = $UKWA_ARCHIVE"


echo "Removing current stack so deployment is completely fresh..."
./shutdown-the-stack.sh

echo "Generate Prometheus configuration from template..."
envsubst < prometheus/prometheus.template.yml > prometheus/prometheus.yml

echo "Ensure there is a folder for Prometheus data..."
mkdir -p ${STORAGE_PATH_SHARED}/prometheus-data

echo "Deploying the stack..."
docker stack deploy --with-registry-auth --prune -c docker-compose.yml $EXTRA_CONFIG access_rrwb
# Wait till it's running...
./wait-for-stack.sh