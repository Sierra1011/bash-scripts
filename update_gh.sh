#!/bin/bash
CURRENT=$(gh version)
LATEST=$(curl https://api.github.com/repos/cli/cli/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
if [ "$CURRENT" != "$LATEST" ]; then
	echo "Installing gh CLI ${LATEST}..."
	wget -P ~ https://github.com/cli/cli/releases/download/v${LATEST}/gh_${LATEST}_linux_amd64.tar.gz
	tar -C ~ -zxvf ~/gh_${LATEST}_linux_amd64.tar.gz
	mv ~/gh_${LATEST}_linux_amd64/bin/gh ~/.bin/gh
	rm -rf ~/gh_${LATEST}_linux_amd64*
else
   echo "Latest gh CLI already installed ($LATEST)."
fi
