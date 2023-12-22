#!/bin/bash

if [[ $1 ]]; then
  VER="v$1"
else
  VER=$(curl -L https://dl.k8s.io/release/stable.txt)
fi
echo "Downloading Kubectl version $VER."

curl -LO "https://dl.k8s.io/release/$VER/bin/linux/amd64/kubectl"

#curl -LO "https://dl.k8s.io/$VER/bin/linux/amd64/kubectl.sha256"
#echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl-$VER
