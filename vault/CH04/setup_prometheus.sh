#!/bin/bash

# Install kube-prometheus to Kubernetes cluster
echo "Installing kube-prometheus ..."
kubectl apply -f kube-prometheus/manifests/
sleep 5
kubectl apply -f kube-prometheus/manifests/

# Install pushgateway via Helm
echo "Installing push-gateway ..."
helm install --name prom-pushgateway stable/prometheus-pushgateway --set serviceMonitor.enabled=true --namespace=monitoring

# Expose pushgateway to LBS
kubectl expose deployment -n monitoring prom-pushgateway-prometheus-pushgateway --port=9091 --target-port=9091 --name=my-pushgateway --type=LoadBalancer

# Check all pod state in Running
echo 'kubectl get pod -n=monitoring'
kubectl get pod -n=monitoring

echo 'Done kube-prometheus installation.'
