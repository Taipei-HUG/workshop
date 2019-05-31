#!/bin/bash

# Install etcd operator to Kubernetes cluster
echo "Installing etcd operator ..."
kubectl create -f vault/etcd-rbac.yaml
kubectl create -f vault/etcd-operator.yaml
sleep 20

# install vault operator to Kubernetes cluser
echo "Installing vault operator ..."
kubectl create -f vault/operator-rbac.yaml
kubectl create -f vault/operator.yaml

# install vault cluser to Kubernetes cluser
echo "Installing vault cluser ..."
kubectl create -f vault/rbac.yaml
kubectl create -f vault/cr-etcd-ha.yaml


