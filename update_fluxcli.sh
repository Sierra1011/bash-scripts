#!/bin/bash
CURRENT=$(flux -v | cut -d " " -f 3)
LATEST=$(curl https://api.github.com/repos/fluxcd/flux2/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
if [ "$CURRENT" != "$LATEST" ]; then
	echo "Installing Flux CLI ${LATEST_RELEASE}..."
	wget -P ~ https://github.com/fluxcd/flux2/releases/download/v${LATEST}/flux_${LATEST}_linux_amd64.tar.gz
	tar -C ~/bin -xvf ~/flux_${LATEST}_linux_amd64.tar.gz
	rm ~/flux_${LATEST}_linux_amd64.tar.gz
else
	echo "Latest Flux CLI already installed."
fi
