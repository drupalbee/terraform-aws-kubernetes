#! /bin/sh
set -e

# Create an IAM role and annotate the Kubernetes service account named aws-load-balancer-controller in the kube-system namespace for the AWS Load Balancer Controller
kubectl apply -f alb-ingress-irsa.yaml

# Install cert-manager to inject certificate configuration into the webhooks.
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.2/cert-manager.yaml

# Install the controller.
# Download the controller specification. For more information about the controller, see the documentation on GitHub.
# https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.1.2/docs/install/v2_1_2_full.yaml
kubectl apply -f ./definition/alb-ingress.yaml


