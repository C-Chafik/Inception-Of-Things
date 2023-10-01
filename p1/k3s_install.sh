#!/bin/bash

echo "**** Begin installing k3s"
apt-get update
apt-get install -y curl
curl -sfL https://get.k3s.io | sh -
echo "**** End installing k3s"
