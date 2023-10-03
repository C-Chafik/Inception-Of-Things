#!/bin/bash

echo "**** Begin installing k3s worker"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" sh -
echo "**** End installing k3s worker"
