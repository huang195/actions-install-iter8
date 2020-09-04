#!/bin/sh

#############################################################
# Check for input parameters
#############################################################

if [ -z "$INPUT_KUBECONFIG" ]; then
  echo "KUBECONFIG input parameter is not set, exiting..."
  exit 1
fi


#############################################################
# Create Kubernetes configuration to access the cluster
#############################################################

mkdir ~/.kube
echo "$INPUT_KUBECONFIG" > ~/.kube/config
cat ~/.kube/config


#############################################################
# Sanity check
#############################################################
kubectl get pods --all-namespaces


#############################################################
# Download and install Iter8
#############################################################

curl -L -s https://raw.githubusercontent.com/iter8-tools/iter8/${INPUT_ITER8_VERSION}/install/install.sh \
| /bin/bash -

kubectl -n iter8 get pods
