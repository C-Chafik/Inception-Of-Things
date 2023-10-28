#!/bin/bash

# Creating the main cluster
k3d cluster create argo-cmarouf --kubeconfig-switch-context

export KUBECONFIG=$(k3d kubeconfig write argo-cmarouf)

# Creating namespaces
kubectl create namespace argocd
kubectl create namespace dev

# Installing ArgoCD & Wil42-App
kubectl apply -f ./confs/install-argocd.yaml -n argocd
kubectl apply -f ./confs/install-app.yaml -n dev

# Wait for ArgoCD to be up
kubectl wait --for=condition=Ready pod --all -n argocd --timeout=600s

# Link Wil42-App to ArgoCD
kubectl apply -f ./confs/argo-project.yaml -n argocd
kubectl apply -f ./confs/argo-application.yaml -n argocd

echo "== ArgoCD Credentials =="
echo "Username: admin"
echo -n "Password: "
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

echo -n "Access ArgoCD Dashboard : "
echo "kubectl port-forward svc/argocd-server -n argocd 8080:443 &>/dev/null &"

echo -n "Expose Wil Application : "
echo "kubectl port-forward svc/wil42-playground-service -n dev 8888:8888 &>/dev/null &"
