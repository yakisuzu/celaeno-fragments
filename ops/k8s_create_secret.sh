#!/bin/sh

GCP_PROJECT_ID="$1"
GCP_ACCOUNT_KEY="$2" # encoded service key
GCP_SERVICE_ACCOUNT="circleci@${GCP_PROJECT_ID}.iam.gserviceaccount.com"
[ "${GCP_PROJECT_ID}" == "" ] && echo "Require. GCP_PROJECT_ID" && exit 1
[ "${GCP_ACCOUNT_KEY}" == "" ] && echo "Require. GCP_ACCOUNT_KEY" && exit 1

# create gcr secret
kubectl create secret docker-registry gcr-secret \
  --docker-server="https://asia.gcr.io" \
  --docker-username="_json_key" \
  --docker-password="$(echo ${GCP_ACCOUNT_KEY} | base64 -di)" \
  --docker-email="${GCP_SERVICE_ACCOUNT}"

kubectl describe secrets gcr-secret
