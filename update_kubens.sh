#!/bin/bash
CURRENT=$(kubectx --version)
LATEST=$(curl https://api.github.com/repos/ahmetb/kubectx/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
if [ "$CURRENT" != "$LATEST" ]; then
   echo "Installing Kubectx ${LATEST}..."
   wget -P ~ https://github.com/ahmetb/kubectx/releases/download/v${LATEST}/kubectx_v${LATEST}_linux_x86_64.tar.gz
   sudo tar -C /usr/local/bin -xvf ~/kubectx_v${LATEST}_linux_x86_64.tar.gz
   wget -P ~ https://github.com/ahmetb/kubectx/releases/download/v${LATEST}/kubens_v${LATEST}_linux_x86_64.tar.gz
   sudo tar -C /usr/local/bin -xvf ~/kubens_v${LATEST}_linux_x86_64.tar.gz
else
   echo "Latest Kubectx/Kubens already installed ($LATEST)."
fi
