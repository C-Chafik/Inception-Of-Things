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

helm --kube-context=k3d-argo-cmarouf install gitlab gitlab/gitlab --set global.hosts.domain=localhost --set certmanager-issuer.email=anremiki@student.42.fr --set global.hosts.https="false" --set global.ingress.configureCertmanager="false" --set gitlab-runner.install="false" --namespace gitlab

kubectl wait --for=condition=available deployment --all -n gitlab --timeout=-1s

echo ""
echo -n "Pass gitlab: "
kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d; echo

echo "kubectl port-forward --address 0.0.0.0 svc/gitlab-webservice-default -n gitlab 8181:8181"
