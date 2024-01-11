#!/bin/bash
CURRENT=$(doctl version | xargs | cut -d' ' -f3)
LATEST=$(curl https://api.github.com/repos/digitalocean/doctl/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
if [ "$CURRENT" != "$LATEST" ]; then
	echo "Installing DOctl ${LATEST_RELEASE}..."
	wget -P ~ https://github.com/digitalocean/doctl/releases/download/v${LATEST_RELEASE}/doctl-${LATEST_RELEASE}-linux-amd64.tar.gz
	tar -xvf ~/doctl-${LATEST_RELEASE}-linux-amd64.tar.gz
	rm ~/doctl-${LATEST_RELEASE}-linux-amd64.tar.gz
	LOCATION="$(which doctl)"
	sudo rm $LOCATION
	sudo mv ~/doctl $LOCATION
	source ~/.bashrc
else
   echo "Latest DOctl already installed."
fi
