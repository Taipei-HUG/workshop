#!/bin/bash

# Remove kube-prometheus
kubectl delete -f kube-prometheus/manifests/

# Remove pushgateway
helm delete prom-pushgateway

# Remove EKS cluster
eksctl delete cluster -f eks_cluster.yml
