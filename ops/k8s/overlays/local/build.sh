#!/bin/sh
cd `dirname $0`

kustomize build . > ../../manifest/local-k8s.yaml
