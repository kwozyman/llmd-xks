#!/bin/bash

source vars

echo "--- 11. Deploying NRI Plugin ---"

kubectl get nodes -o custom-columns=":metadata.name" --no-headers | while read node; do
    echo "$node"
    kubectl debug "node/${node}" -it --image=fedora --profile=sysadmin -- bash -c 'echo "[plugins.\"io.containerd.nri.v1.nri\"]" > /host/etc/containerd/conf.d/98-llmd.toml'
    kubectl debug "node/${node}" -it --image=fedora --profile=sysadmin -- bash -c 'echo "  disable = false" >> /host/etc/containerd/conf.d/98-llmd.toml'
    kubectl debug "node/${node}" -it --image=fedora --profile=sysadmin -- chroot /host systemctl restart containerd
done

kubectl apply -k https://github.com/containerd/nri/contrib/kustomize/ulimit-adjuster

