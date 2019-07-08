#!/bin/sh

GCP_PROJECT_ID="$1"
GCP_REGION="$2"
GCP_CLUSTER_NAME="$3"
[ "${GCP_PROJECT_ID}" == "" ] && echo "Require. GCP_PROJECT_ID" && exit 1
[ "${GCP_REGION}" == "" ] && echo "Require. GCP_REGION" && exit 1
[ "${GCP_CLUSTER_NAME}" == "" ] && echo "Require. GCP_CLUSTER_NAME" && exit 1

CLUSTER_VERSION="1.13.6-gke.13"
MACHINE_TYPE="g1-small"
NUM_NODES=1

# create cluster
gcloud config set container/new_scopes_behavior true
gcloud container clusters create "${GCP_CLUSTER_NAME}" \
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
  --network "projects/${GCP_PROJECT_ID}/global/networks/default" \
  --subnetwork "projects/${GCP_PROJECT_ID}/regions/${GCP_REGION}/subnetworks/default" \
  --max-nodes-per-pool "100" \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --no-issue-client-certificate \
  --enable-autoupgrade \
  --enable-autorepair
