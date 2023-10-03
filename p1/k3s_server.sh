#!/bin/bash

echo "**** Begin installing k3s server"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" sh -
echo "**** End installing k3s server"

echo "**** Begin installing kubectl"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
echo "alias k='kubectl'" >> .bashrc
echo "**** End installing kubectl"

