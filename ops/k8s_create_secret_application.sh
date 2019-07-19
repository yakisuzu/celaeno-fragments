#!/bin/sh

GCP_ACCOUNT_KEY="$1" # encoded service key
[ "${GCP_ACCOUNT_KEY}" == "" ] && echo "Require. GCP_ACCOUNT_KEY" && exit 1

# create secret application
GCP_ACCOUNT_KEY_PATH="./application-gcp-secret.json"
echo "$GCP_ACCOUNT_KEY" | base64 -di > "${GCP_ACCOUNT_KEY_PATH}"
kubectl create secret generic application-gcp-secret \
  --from-file="key.json=${GCP_ACCOUNT_KEY_PATH}"
rm "${GCP_ACCOUNT_KEY_PATH}"

kubectl describe secrets application-gcp-secret
