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

# プロジェクトのポリシー一覧
# gcloud projects get-iam-policy ${PROJECT_ID}

# リソースに付与できるロール一覧
# gcloud iam roles list

# ロールのあてかた
# https://cloud.google.com/iam/docs/granting-roles-to-service-accounts?hl=ja

# iam create circleci
IAM_NAME_CIRCLECI="circleci"
SERVICE_ACCOUNT_NAME_CIRCLECI=${IAM_NAME_CIRCLECI}@${PROJECT_ID}.iam.gserviceaccount.com
gcloud iam service-accounts create ${IAM_NAME_CIRCLECI} --display-name=${IAM_NAME_CIRCLECI} 2>&1

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
   --member serviceAccount:${SERVICE_ACCOUNT_NAME_CIRCLECI} \
   --role roles/storage.admin
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
   --member serviceAccount:${SERVICE_ACCOUNT_NAME_CIRCLECI} \
   --role roles/container.clusterAdmin

# TODO 違うかも
# gcloud iam service-accounts get-iam-policy ${SERVICE_ACCOUNT_NAME_CIRCLECI}

# TODO 必要になったら
# iam create application
#IAM_NAME_APP="application"
#SERVICE_ACCOUNT_NAME_APP=${IAM_NAME_APP}@${PROJECT_ID}.iam.gserviceaccount.com
#gcloud iam service-accounts create ${IAM_NAME_APP} --display-name=${IAM_NAME_APP} 2>&1

#gcloud iam service-accounts get-iam-policy ${SERVICE_ACCOUNT_NAME_APP}

popd > /dev/null
