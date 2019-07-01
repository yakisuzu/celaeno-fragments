#!/bin/sh
pushd $(dirname `greadlink -f $0`) > /dev/null

PROJECT_ID="$1"
CLOUDSDK_COMPUTE_ZONE="asia-southeast1-a"
CLOUDSDK_COMPUTE_REGION="asia-southeast1"
CLUSTER_NAME="$2"
GCLOUD_SERVICE_KEY_ENCODED="$3"
[ "${PROJECT_ID}" == "" ] && echo "Require. PROJECT_ID" && popd > /dev/null && exit 1
[ "${CLUSTER_NAME}" == "" ] && echo "Require. CLUSTER_NAME" && popd > /dev/null && exit 1
[ "${GCLOUD_SERVICE_KEY_ENCODED}" == "" ] && echo "Require. GCLOUD_SERVICE_KEY_ENCODED" && popd > /dev/null && exit 1

# 超権限でつくる
. ./gke_config_setup.sh ${PROJECT_ID} ${CLOUDSDK_COMPUTE_ZONE} ${CLOUDSDK_COMPUTE_REGION} ${CLUSTER_NAME}
gcloud auth login
gcloud config configurations list

## kubectl setup
gcloud container clusters get-credentials ${CLUSTER_NAME}
### local
kubectl config use-context docker-for-desktop
### gcp
#kubectl config use-context ${PROJECT_ID}

# TODO create gcr secret
kubectl create secret docker-registry gcr-secret \
  --docker-server=https://asia.gcr.io \
  --docker-username=_json_key \
  --docker-password=$(echo ${GCLOUD_SERVICE_KEY_ENCODED} | base64 -di) \
  --docker-email=circleci@celaeno-fragments.iam.gserviceaccount.com

popd > /dev/null
