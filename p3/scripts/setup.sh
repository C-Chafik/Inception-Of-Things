#!/bin/bash

# Install K3D
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Creating the main cluster
k3d cluster create argo-cmarouf -p 8080:80@loadbalancer --kubeconfig-switch-context

KUBECONFIG=$(k3d kubeconfig write argo-cmarouf)

# Creating namespaces
kubectl create namespace argocd
kubectl create namespace dev

# Installing ArgoCD
kubectl apply -f ./confs/install-argocd.yaml -n argocd
kubectl apply -f ./confs/install-dev.yaml -n dev

echo "! Run the following commands to access ArgoCD Pannel : !"
echo " >>> kubectl port-forward svc/argocd-server -n argocd 8080:80 <<< "
