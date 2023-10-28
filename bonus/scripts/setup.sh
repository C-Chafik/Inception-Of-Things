#!/bin/bash


export KUBECONFIG=~/.kube/config

kubectl config use-context k3d-argo-cmarouf

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
sudo ./get_helm.sh
rm -rf get_helm.sh

kubectl create namespace gitlab

helm repo add gitlab https://charts.gitlab.io
helm repo update

export HELM_KUBE_CONTEXT=k3d-argo-cmarouf

helm --kube-context=k3d-argo-cmarouf install gitlab gitlab/gitlab --namespace gitlab --set global.hosts.domain=localhost --set certmanager-issuer.email=anremiki@student.42.fr

kubectl wait --for=condition=Ready pod --all -n gitlab --timeout=600s

kubectl apply -f ./confs/gitlab-argo-application.yaml -n argocd

sleep 10

kubectl patch appprojects.argoproj.io argo-project -n argocd --type='json' -p='[{"op": "add", "path": "/spec/destinations/-", "value": {"server": "https://kubernetes.default.svc", "namespace": "gitlab"}}]'
kubectl patch appprojects.argoproj.io argo-project -n argocd --type='json' -p='[{"op": "add", "path": "/spec/sourceRepos/-", "value": "https://gitlab.com/anremiki/*"}]'
