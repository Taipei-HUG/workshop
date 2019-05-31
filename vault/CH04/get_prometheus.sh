#!/bin/sh

echo "Grafana"
echo "http://"$(kubectl get svc grafana -n monitoring -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")":3000"

echo "Prometheus"
echo "http://"$(kubectl get svc prometheus-k8s -n monitoring -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")":9090"

echo "Pushgateway"
echo "http://"$(kubectl get svc my-pushgateway -n monitoring -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")":9091"

echo "Alertmanager"
echo "http://"$(kubectl get svc alertmanager-main -n monitoring -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")":9093"
