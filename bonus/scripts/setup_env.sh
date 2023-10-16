#!/bin/bash

sudo apt-get -y update

sudo apt-get install -y curl

sudo apt-get install y virtualbox

wget https://releases.hashicorp.com/vagrant/2.2.19/vagrant_2.2.19_x86_64.deb

sudo apt install -y ./vagrant_2.2.19_x86_64.deb

rm -rf ./vagrant_2.2.19_x86_64.deb
# Install K3S

curl -sfL https://get.k3s.io | sh -

# Docker for K3D
snap install docker

# Install K3D
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

export PATH="$PATH:/snap/bin"
