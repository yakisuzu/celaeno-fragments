#!/bin/sh

GCP_PROJECT_ID="$1"
[ "${GCP_PROJECT_ID}" == "" ] && echo "Require. GCP_PROJECT_ID" && exit 1

# リソースに付与できるロール一覧
# gcloud iam roles list

# ロールのあてかた
# https://cloud.google.com/iam/docs/granting-roles-to-service-accounts?hl=ja

# iam create circleci
IAM_NAME_CIRCLECI="circleci"
SERVICE_ACCOUNT_NAME_CIRCLECI=${IAM_NAME_CIRCLECI}@${GCP_PROJECT_ID}.iam.gserviceaccount.com
gcloud iam service-accounts create ${IAM_NAME_CIRCLECI} --display-name=${IAM_NAME_CIRCLECI} 2>&1

gcloud projects add-iam-policy-binding ${GCP_PROJECT_ID} \
   --member serviceAccount:${SERVICE_ACCOUNT_NAME_CIRCLECI} \
   --role roles/storage.admin
gcloud projects add-iam-policy-binding ${GCP_PROJECT_ID} \
   --member serviceAccount:${SERVICE_ACCOUNT_NAME_CIRCLECI} \
   --role roles/container.clusterAdmin
gcloud projects add-iam-policy-binding ${GCP_PROJECT_ID} \
   --member serviceAccount:${SERVICE_ACCOUNT_NAME_CIRCLECI} \
   --role roles/container.admin

# TODO 必要になったら
# iam create application
#IAM_NAME_APP="application"
#SERVICE_ACCOUNT_NAME_APP=${IAM_NAME_APP}@${GCP_PROJECT_ID}.iam.gserviceaccount.com
#gcloud iam service-accounts create ${IAM_NAME_APP} --display-name=${IAM_NAME_APP} 2>&1

gcloud projects get-iam-policy ${GCP_PROJECT_ID}
