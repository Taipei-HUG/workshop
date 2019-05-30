#!/bin/bash

mkdir ~/bin

echo "Get binary of vault, kubectl, eksctl, aws-iam-authenticator ..."

wget https://releases.hashicorp.com/vault/1.1.2/vault_1.1.2_linux_amd64.zip && unzip vault_1.1.2_linux_amd64.zip && chmod +x vault && sudo mv vault /usr/local/bin && rm vault_1.1.2_linux_amd64.zip

wget https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl ~/bin/

wget https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator && chmod +x aws-iam-authenticator && mv aws-iam-authenticator ~/bin/

curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

echo "Install docker-compose"
sudo apt install docker-compose -y

echo 'Done.'
