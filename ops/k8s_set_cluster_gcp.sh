#!/bin/sh

GCP_CLUSTER_NAME="$1"
[ "${GCP_CLUSTER_NAME}" == "" ] && echo "Require. GCP_CLUSTER_NAME" && exit 1

gcloud container clusters get-credentials ${GCP_CLUSTER_NAME}
kubectl config get-contexts
