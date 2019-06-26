#!/bin/sh

PROJECT_ID="$1"
CLOUDSDK_COMPUTE_ZONE="$2"
CLOUDSDK_COMPUTE_REGION="$3"
CLUSTER_NAME="$4"
[ "${PROJECT_ID}" == "" ] && echo "Require. PROJECT_ID" && exit 1
[ "${CLOUDSDK_COMPUTE_ZONE}" == "" ] && echo "Require. CLOUDSDK_COMPUTE_ZONE" && exit 1
[ "${CLOUDSDK_COMPUTE_REGION}" == "" ] && echo "Require. CLOUDSDK_COMPUTE_REGION" && exit 1
[ "${CLUSTER_NAME}" == "" ] && echo "Require. CLUSTER_NAME" && exit 1

# gcloud setup
gcloud config configurations create ${PROJECT_ID} 2> /dev/null
gcloud config configurations activate ${PROJECT_ID}
gcloud config set project ${PROJECT_ID}
gcloud config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud config set compute/region ${CLOUDSDK_COMPUTE_REGION}
gcloud config set container/cluster ${CLUSTER_NAME}
