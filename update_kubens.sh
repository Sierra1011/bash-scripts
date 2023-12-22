#!/bin/bash
CURRENT=$(kubectx --version)
LATEST=$(curl https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
if [ "$CURRENT" != "$LATEST" ]; then
	echo "Installing Kubectx ${LATEST}..."
	NAME="""kubectx_v"$LATEST"_linux_amd64.tar.gz"""
        FILTER=".assets[] | select(.\"name\"==\"$NAME\").browser_download_url"
        BDURL=$(curl https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq -r "$FILTER")
        wget -P ~/ $BDURL
	tar -C ~/.bin -xvf ~/kubectx_v${LATEST}_linux_x86_64.tar.gz
        echo "Kubectx v${LATEST} installed."
        echo "Installing Kubens ${LATEST}..."
	NAME="""kubens_v"$LATEST"_linux_amd64.tar.gz"""
        FILTER=".assets[] | select(.\"name\"==\"$NAME\").browser_download_url"
        BDURL=$(curl https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq -r "$FILTER")
        wget -P ~/ $BDURL
	tar -C ~/.bin -xvf ~/kubens_v${LATEST}_linux_x86_64.tar.gz
	echo "Kubens v${LATEST} installed."
else
	echo "Latest Kubectx/Kubens already installed ($LATEST)."
fi
