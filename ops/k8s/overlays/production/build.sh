#!/bin/sh
cd `dirname $0`

IMAGE_NAME="$1"
[ "${IMAGE_NAME}" == "" ] && echo "Require. IMAGE_NAME" && exit 1

kustomize edit set image app=${IMAGE_NAME}
kustomize build . > ../../manifest/prd-k8s.yaml
