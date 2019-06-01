#!/bin/bash

# Install kube-prometheus to Kubernetes cluster
echo "Installing kube-prometheus ..."
kubectl apply -f kube-prometheus/manifests/
sleep 5
kubectl apply -f kube-prometheus/manifests/

# Check all pod state in Running
echo 'kubectl get pod -n=monitoring'
kubectl get pod -n=monitoring

echo 'Done kube-prometheus installation.'
