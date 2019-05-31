#!/bin/bash

# Get helm into instance
echo 'Installing helm to this instance and into Kubernetes ...'
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# Install tiller for helm and set tiller role to cluster-admin
kubectl apply -f https://gist.githubusercontent.com/pahud/14e6cc08f3a7e65cd9b0e8bed454a901/raw/954d71614dda911c4f7960f0d18687fa1ea093fa/helm-sa-rolebinding.yaml

# Initial helm into kubernetes
helm init --service-account tiller --upgrade

echo 'Done helm installation.'
