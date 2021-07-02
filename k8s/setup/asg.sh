#! /bin/sh
set -e

# Annotate the cluster-autoscaler service account with the ARN of the IAM role that you created previously.
kubectl apply -f asg-irsa.yaml

# Deploy the Cluster Autoscaler.
# Patch the deployment to add the cluster-autoscaler.kubernetes.io/safe-to-evict annotation to the Cluster Autoscaler pods
# Edit the cluster-autoscaler container command to replace <YOUR CLUSTER NAME> (including <>) with your cluster's name
kubectl apply -f ./definition/asg.yaml