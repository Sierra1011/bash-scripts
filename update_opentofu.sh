#!/bin/bash
CURRENT=$(tofu version -json | jq '.terraform_version' --raw-output)
LATEST=$(curl https://api.github.com/repos/opentofu/opentofu/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
if [ "$CURRENT" != "$LATEST" ]; then
	echo "Installing openTofu CLI ${LATEST}..."
	NAME="""tofu_"$LATEST"_linux_amd64.zip"""
	FILTER=".assets[] | select(.\"name\"==\"$NAME\").browser_download_url"
	BDURL=$(curl https://api.github.com/repos/opentofu/opentofu/releases/latest | jq -r "$FILTER")
	wget -P ~/ $BDURL
	sudo unzip -o ~/$NAME tofu -d /usr/local/bin && rm ~/$NAME
else
	echo "Latest openTofu already installed ($LATEST)."
fi
