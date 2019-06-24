#!/bin/bash
CLUSTER_NAME="$1"
PROJECT_ID="$2"
GCLOUD_SERVICE_KEY_ENCODED="$3" # cat xxxxxxx.json | base64 -w 0
[ "${CLUSTER_NAME}" == "" ] && echo "Require. CLUSTER_NAME" && exit 1
[ "${PROJECT_ID}" == "" ] && echo "Require. PROJECT_ID" && exit 1
[ "${GCLOUD_SERVICE_KEY_ENCODED}" == "" ] && echo "Require. GCLOUD_SERVICE_KEY_ENCODED" && exit 1

CLOUDSDK_COMPUTE_ZONE="asia-southeast1-a"
CLOUDSDK_COMPUTE_REGION="asia-southeast1"
CLUSTER_VERSION="1.13.6-gke.13"
MACHINE_TYPE="g1-small"
NUM_NODES=1

# gcloud setup
gcloud config configurations create ${PROJECT_ID} 2> /dev/null
gcloud config configurations activate ${PROJECT_ID}
gcloud config set project ${PROJECT_ID}
gcloud config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud config set compute/region ${CLOUDSDK_COMPUTE_REGION}
gcloud config set container/cluster ${CLUSTER_NAME}
echo ${GCLOUD_SERVICE_KEY_ENCODED} | base64 --decode -i | gcloud auth activate-service-account --key-file=-
gcloud config configurations list
gcloud auth configure-docker --quiet

echo "コメントアウトして使う" && exit 0

# disable cluster
#gcloud container clusters resize "${CLUSTER_NAME}" --size=0 --quiet && exit 0

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
  --default-max-pods-per-node "110" \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --no-issue-client-certificate \
  --enable-autoupgrade \
  --enable-autorepair

