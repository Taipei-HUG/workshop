#!/bin/sh

echo "Grafana"
echo "http://"$(kubectl get svc grafana -n monitoring -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")":3000"

echo "Prometheus"
echo "http://"$(kubectl get svc prometheus-k8s -n monitoring -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")":9090"

echo "Alertmanager"
echo "http://"$(kubectl get svc alertmanager-main -n monitoring -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")":9093"
