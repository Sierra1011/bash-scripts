#!/bin/bash
VERSION=$(curl https://go.dev/dl/?mode=json | grep -o 'go.*.linux-amd64.tar.gz' | head -n 1 | tr -d '\r\n')
FILE="/tmp/$VERSION"
sudo rm -rf /usr/local/go
touch $FILE
wget -O $FILE https://go.dev/dl/$VERSION
sudo tar -C /usr/local -xzf $FILE
export PATH=$PATH:/usr/local/go/bin
echo $(go version)
