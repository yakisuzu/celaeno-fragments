#!/bin/sh
pushd $(dirname `greadlink -f $0`) > /dev/null

IMAGE_NAME="$1"
[ "${IMAGE_NAME}" == "" ] && echo "Require. IMAGE_NAME" && popd > /dev/null && exit 1

kustomize edit set image app=${IMAGE_NAME}
kustomize build . > ../../manifest/prd-k8s.yaml

popd > /dev/null
