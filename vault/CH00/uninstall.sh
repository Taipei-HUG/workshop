#!/bin/bash

# Remove EKS cluster
eksctl delete cluster -f eks_cluster.yml
