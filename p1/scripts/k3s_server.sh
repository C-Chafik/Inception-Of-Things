#!/bin/bash

echo "**** Begin installing k3s server"

sudo apt-get update
sudo apt-get install -y curl
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" sh -
# Saving the token for the agent in the shared
cp /var/lib/rancher/k3s/server/node-token /vagrant_shared/k3s_server_token

echo "**** End installing k3s server"

echo "alias k='kubectl'" >> .bashrc
