#!/bin/sh

GCP_PROJECT_ID="$1"
[ "${GCP_PROJECT_ID}" == "" ] && echo "Require. GCP_PROJECT_ID" && exit 1

gcloud config configurations activate ${GCP_PROJECT_ID}
