#!/bin/sh
pushd $(dirname `greadlink -f $0`) > /dev/null

PROJECT_ID="$1"
CLOUDSDK_COMPUTE_ZONE="asia-southeast1-a"
CLOUDSDK_COMPUTE_REGION="asia-southeast1"
CLUSTER_NAME="$2"
[ "${PROJECT_ID}" == "" ] && echo "Require. PROJECT_ID" && popd > /dev/null && exit 1
[ "${CLUSTER_NAME}" == "" ] && echo "Require. CLUSTER_NAME" && popd > /dev/null && exit 1

# service account作る前なので、仕方なく普通にログイン
. ./gke_config_setup.sh ${PROJECT_ID} ${CLOUDSDK_COMPUTE_ZONE} ${CLOUDSDK_COMPUTE_REGION} ${CLUSTER_NAME}
gcloud auth login
gcloud config configurations list

# リソースに付与できるロール一覧
gcloud iam roles list

# ポリシーのあてかた
# https://cloud.google.com/iam/docs/managing-policies

# iam create deploy
IAM_NAME="deploy"
gcloud iam service-accounts create ${IAM_NAME} --display-name=${IAM_NAME} 2>&1

# iam set policy
#gcloud iam service-accounts set-iam-policy \
#  ${IAM_NAME}@${PROJECT_ID}.iam.gserviceaccount.com \
#  ./gke_create_service_account_${IAM_NAME}.json
#gcloud projects add-iam-policy-binding ${PROJECT_ID} \
#   --member user:${IAM_NAME}@${PROJECT_ID}.iam.gserviceaccount.com --role roles/editor

# iam app

popd > /dev/null
