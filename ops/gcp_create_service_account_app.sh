#!/bin/sh
# 環境でわけない(GCPはリソース制限がない)
GCP_PROJECT_ID="$1"
GCP_ACCOUNT_NAME="$2"
[ "${GCP_PROJECT_ID}" == "" ] && echo "Require. GCP_PROJECT_ID" && exit 1
[ "${GCP_ACCOUNT_NAME}" == "" ] && echo "Require. GCP_ACCOUNT_NAME" && exit 1

# リソースに付与できるロール一覧
# gcloud iam roles list

# ロールのあてかた
# https://cloud.google.com/iam/docs/granting-roles-to-service-accounts?hl=ja

# iam create
GCP_ACCOUNT_MAIL=${GCP_ACCOUNT_NAME}@${GCP_PROJECT_ID}.iam.gserviceaccount.com
gcloud iam service-accounts create ${GCP_ACCOUNT_NAME} --display-name=${GCP_ACCOUNT_NAME} 2>&1

# TODO cse
#gcloud projects add-iam-policy-binding ${GCP_PROJECT_ID} \
#   --member serviceAccount:${GCP_ACCOUNT_MAIL} \
#   --role roles/storage.admin

gcloud projects get-iam-policy ${GCP_PROJECT_ID}
