#!/bin/bash

source vars

echo "--- 6. Helm install GPU Operator ---"
helm repo add nvidia https://helm.ngc.nvidia.com/nvidia
helm repo update

helm install --wait -n gpu-operator --create-namespace \
    gpu-operator nvidia/gpu-operator \
    --version "${GPU_OPERATOR_VERSION}" \
    --set "driver.rdma.enabled=true"

