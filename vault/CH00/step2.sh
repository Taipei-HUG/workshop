#!/bin/bash

# Create eks cluster using eksctl
echo "Creating eks cluster and node group with two t3.large instances ..."
eksctl create cluster -f eks_cluster.yml

# Get KUBECONFIG then kubectl can work
aws eks update-kubeconfig --name workshop

# Test if kubernate cluster works good
kubectl get all

echo 'Done setting EKS.'
