#!/bin/bash

source vars

echo "--- 10. Deploying Network Operator ---"
rm -rf llm-d && git clone -b "${LLMD_VERSION}" --depth 1 https://github.com/llm-d/llm-d.git

cd llm-d/docs/infra-providers/aks
helmfile apply -f network-operator.helmfile.yaml
kubectl apply -f nic-cluster-policy.yaml
cd ../../../

