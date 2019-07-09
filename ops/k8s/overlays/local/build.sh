#!/bin/sh
pushd $(dirname `greadlink -f $0`) > /dev/null

kustomize build . > ../../manifest/local-k8s.yaml

popd > /dev/null
