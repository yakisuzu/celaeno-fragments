#!/bin/sh

GCP_CLUSTER_NAME="$1"
GCP_CLUSTER_SIZE="$2" # 0 or 1
[ "${GCP_CLUSTER_NAME}" == "" ] && echo "Require. GCP_CLUSTER_NAME" && exit 1
[ "${GCP_CLUSTER_SIZE}" == "" ] && echo "Require. GCP_CLUSTER_SIZE" && exit 1

# change cluster size
gcloud container clusters resize "${GCP_CLUSTER_NAME}" --size=${GCP_CLUSTER_SIZE} --quiet
