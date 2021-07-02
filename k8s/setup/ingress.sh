#! /bin/sh
set -e

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/aws/deploy.yaml

kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

