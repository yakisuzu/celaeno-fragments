#!/bin/sh
pushd $(dirname `greadlink -f $0`) > /dev/null

PROJECT_ID="$1"
CLOUDSDK_COMPUTE_ZONE="asia-southeast1-a"
CLOUDSDK_COMPUTE_REGION="asia-southeast1"
CLUSTER_NAME="$2"
[ "${PROJECT_ID}" == "" ] && echo "Require. PROJECT_ID" && popd > /dev/null && exit 1
[ "${CLUSTER_NAME}" == "" ] && echo "Require. CLUSTER_NAME" && popd > /dev/null && exit 1

CLUSTER_VERSION="1.13.6-gke.13"
MACHINE_TYPE="g1-small"
NUM_NODES=1

# clusterは超権限でつくる
. ./gke_config_setup.sh ${PROJECT_ID} ${CLOUDSDK_COMPUTE_ZONE} ${CLOUDSDK_COMPUTE_REGION} ${CLUSTER_NAME}
gcloud auth login
gcloud config configurations list

echo "コメントアウトして使う" && popd > /dev/null && exit 0

# kubectl setup
# gcloud container clusters get-credentials ${CLUSTER_NAME}

# local gcr credential setup
# gcloud components install docker-credential-gcr --quiet
# docker-credential-gcr configure-docker
# https://cloud.google.com/container-registry/docs/access-control

# disable cluster
#gcloud container clusters resize "${CLUSTER_NAME}" --size=0 --quiet && popd > /dev/null && exit 0

# create cluster
gcloud config set container/new_scopes_behavior true
gcloud container clusters create "${CLUSTER_NAME}" \
  --no-enable-basic-auth \
  --cluster-version "${CLUSTER_VERSION}" \
  --machine-type "${MACHINE_TYPE}" \
  --image-type "COS" \
  --disk-type "pd-standard" \
  --disk-size "30" \
  --metadata disable-legacy-endpoints=true \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
  --num-nodes "${NUM_NODES}" \
  --enable-cloud-logging \
  --enable-cloud-monitoring \
  --enable-ip-alias \
  --network "projects/${PROJECT_ID}/global/networks/default" \
  --subnetwork "projects/${PROJECT_ID}/regions/${CLOUDSDK_COMPUTE_REGION}/subnetworks/default" \
  --max-nodes-per-pool "100" \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --no-issue-client-certificate \
  --enable-autoupgrade \
  --enable-autorepair

popd > /dev/null
