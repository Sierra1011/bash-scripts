#!/bin/bash
CURRENT=$(kustomize version)
LATEST=$(curl https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest | jq --raw-output '.tag_name' | cut -d'/' -f2)
if [ "$CURRENT" != "$LATEST" ]; then
	echo "Installing Kustomize ${LATEST}..."
	NAME="""kustomize_"$LATEST"_linux_amd64.tar.gz"""
	FILTER=".assets[] | select(.\"name\"==\"$NAME\").browser_download_url"
	BDURL=$(curl https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest | jq -r "$FILTER")
	wget -P ~/ $BDURL
	tar -xvf ~/$NAME -C ~/.bin && rm ~/$NAME
	"Kustomize ($LATEST) installed."
else
	echo "Latest Kustomize already installed ($LATEST)."
fi
