#!/bin/bash

# Install K3D
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

k3d cluster create argo-cmarouf -p 8080:80@loadbalancer --kubeconfig-switch-context

KUBECONFIG=$(k3d kubeconfig write argo-cmarouf)

kubectl create namespace argocd
kubectl create namespace dev

