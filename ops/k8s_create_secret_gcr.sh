#!/bin/sh

GCP_PROJECT_ID="$1"
GCP_ACCOUNT_NAME="$2" # deploy service account
GCP_ACCOUNT_KEY="$3" # encoded service key
[ "${GCP_PROJECT_ID}" == "" ] && echo "Require. GCP_PROJECT_ID" && exit 1
[ "${GCP_ACCOUNT_NAME}" == "" ] && echo "Require. GCP_ACCOUNT_NAME" && exit 1
[ "${GCP_ACCOUNT_KEY}" == "" ] && echo "Require. GCP_ACCOUNT_KEY" && exit 1

# create secret gcr
GCP_ACCOUNT_MAIL="${GCP_ACCOUNT_NAME}@${GCP_PROJECT_ID}.iam.gserviceaccount.com"
kubectl create secret docker-registry gcr-secret \
  --docker-server="https://asia.gcr.io" \
  --docker-username="_json_key" \
  --docker-password="$(echo ${GCP_ACCOUNT_KEY} | base64 -di)" \
  --docker-email="${GCP_ACCOUNT_MAIL}"

kubectl describe secrets gcr-secret
