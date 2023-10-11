#!/bin/bash

apt-get -y update

apt-get install -y curl

# Install K3S

curl -sfL https://get.k3s.io | sh -

# Docker for K3D
snap install docker

# Install K3D
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
