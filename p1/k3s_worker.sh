#!/bin/bash

echo "**** Begin installing k3s worker"
sudo apt-get update
sudo apt-get install -y curl

ssh-keyscan 192.168.56.110 >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | ssh vagrant@192.168.56.110 "cat >> ~/.ssh/authorized_keys"

TOKEN=$(ssh vagrant@192.168.56.110 'sudo cat /var/lib/rancher/k3s/server/node-token')
curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="--flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=${TOKEN} sh -

sudo k3s kubectl get node
echo "**** End installing k3s worker"
