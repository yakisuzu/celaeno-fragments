#!/bin/sh
cd `dirname $0`

CSE_API="$1"
CSE_CX="$2"
IMAGE_NAME="$3"
[ "${CSE_API}" == "" ] && echo "Require. CSE_API" && exit 1
[ "${CSE_CX}" == "" ] && echo "Require. CSE_CX" && exit 1
[ "${IMAGE_NAME}" == "" ] && echo "Require. IMAGE_NAME" && exit 1

# secret
echo "CSE_API=${CSE_API}" > .env
echo "CSE_CX=${CSE_CX}" >> .env

# build
kustomize edit set image app="${IMAGE_NAME}"
kustomize build . > ../../manifest/prd-k8s.yaml
