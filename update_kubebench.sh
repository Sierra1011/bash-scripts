#!/bin/bash
CURRENT=$(kube-bench version)
LATEST=$(curl https://api.github.com/repos/aquasecurity/kube-bench/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
if [ "$CURRENT" != "$LATEST" ]; then
	echo "Installing Kube-Bench CLI ${LATEST}..."
	NAME="""kube-bench_"$LATEST"_linux_amd64.tar.gz"""
	FILTER=".assets[] | select(.\"name\"==\"$NAME\").browser_download_url"
	BDURL=$(curl https://api.github.com/repos/aquasecurity/kube-bench/releases/latest | jq -r "$FILTER")
	wget -P ~/ $BDURL
	sudo tar -xvf ~/$NAME kube-bench -C /usr/local/bin/kube-bench && \
	tar -xv ~/$NAME && rm ~/kube-bench
	rm ~/$NAME
else
	echo "Latest Kube-Bench already installed ($LATEST)."
fi
