#!/bin/bash

# Remove vault cluster
kubectl delete -f vault/cr-etcd-ha.yaml
kubectl delete -f vault/rbac.yaml
kubectl delete -f vault/operator.yaml
kubectl delete -f vault/operator-rbac.yaml
kubectl delete -f vault/etcd-operator.yaml
kubectl delete -f vault/etcd-rbac.yaml
kubectl delete -f vault/servicemonitor.yaml

# Remove kube-prometheus
kubectl delete -f kube-prometheus/manifests/

# Remove pushgateway
helm delete prom-pushgateway

# Remove EKS cluster
eksctl delete cluster -f ../CH00/eks_cluster.yml
