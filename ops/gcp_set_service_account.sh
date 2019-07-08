#!/bin/sh

GCP_ACCOUNT_KEY="$1" # encoded service key
[ "${GCP_ACCOUNT_KEY}" == "" ] && echo "Require. GCP_ACCOUNT_KEY" && exit 1

echo ${GCP_ACCOUNT_KEY} | base64 -di | gcloud auth activate-service-account --key-file=-
gcloud config configurations list
