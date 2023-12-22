curl -sL https://releases.hashicorp.com/terraform/index.json | jq
unzip terraform.zip
sudo mv terraform /usr/local/bin
terraform -install-autocomplete
source ~/.bashrc
