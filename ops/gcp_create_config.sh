#!/bin/sh

GCP_PROJECT_ID="$1"
GCP_ZONE="$2"
GCP_REGION="$3"
GCP_CLUSTER_NAME="$4"
[ "${GCP_PROJECT_ID}" == "" ] && echo "Require. GCP_PROJECT_ID" && exit 1
[ "${GCP_ZONE}" == "" ] && echo "Require. GCP_ZONE" && exit 1
[ "${GCP_REGION}" == "" ] && echo "Require. GCP_REGION" && exit 1
[ "${GCP_CLUSTER_NAME}" == "" ] && echo "Require. GCP_CLUSTER_NAME" && exit 1

# gcloud setup
gcloud config configurations create ${GCP_PROJECT_ID} 2> /dev/null
gcloud config configurations activate ${GCP_PROJECT_ID}
gcloud config set project ${GCP_PROJECT_ID}
gcloud config set compute/zone ${GCP_ZONE}
gcloud config set compute/region ${GCP_REGION}
gcloud config set container/cluster ${GCP_CLUSTER_NAME}

gcloud config configurations list
