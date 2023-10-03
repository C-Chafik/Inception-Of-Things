#!/bin/bash

echo "**** Begin installing k3s worker"

sudo apt-get update
sudo apt-get install -y curl

TOKEN=$(cat /vagrant_shared/k3s_server_token)
curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="--flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=${TOKEN} sh -

echo "**** End installing k3s worker"

# Clear the token
rm -rf /vagrant_shared/k3s_server_token

echo "alias k='kubectl'" >> .bashrc
