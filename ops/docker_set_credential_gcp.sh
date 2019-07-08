#!/bin/sh

gcloud auth configure-docker --quiet

echo "https://asia.gcr.io" | docker-credential-gcloud get
cat ~/.docker/config.json

# docker-credential-gcr のことは忘れていい
# https://cloud.google.com/container-registry/docs/access-control

# k8sのcredentialはyamlにて
# https://kubernetes.io/docs/concepts/containers/images/#referring-to-an-imagepullsecrets-on-a-pod
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
# https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/
# https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters
# https://cloud.google.com/container-registry/docs/advanced-authentication

