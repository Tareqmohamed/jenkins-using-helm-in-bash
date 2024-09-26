#!/bin/bash

# Set default values for jenkins_name and port
jenkins_name=${1:-"my-jenkins"}
port=${2:-8089}

# Check if Minikube is running
minikube status > /dev/null
if [ $? -ne 0 ]; then
  echo "Minikube is not running"
  minikube start
  sleep 100
fi
echo "Minikube is running"

# Check if the Jenkins repo is added
helm repo list | grep jenkins > /dev/null
if [ $? -ne 0 ]; then
  echo "Jenkins Helm repo is not added"
  helm repo add jenkins https://charts.jenkins.io
  helm repo update
  echo "Jenkins Helm repo is added"
else
  echo "Jenkins Helm repo is already added"
fi

# Check if Jenkins is installed
helm list | grep ${jenkins_name} > /dev/null
if [ $? -ne 0 ]; then
  echo "Jenkins is not installed, installing Jenkins"
  helm install ${jenkins_name} jenkinsci/jenkins --version 5.7.0
  echo "Jenkins is installed"
else
  echo "Jenkins is already installed"
fi

# Check if Jenkins is running
kubectl get pods | grep ${jenkins_name} > /dev/null
if [ $? -ne 0 ]; then
  echo "Jenkins pod is not running"
  exit 1
fi
echo "Jenkins is running"

# Print the Jenkins initial admin password
echo "Fetching Jenkins initial admin password..."
kubectl exec --namespace default -it svc/${jenkins_name}-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo

# Port forwarding the Jenkins service
echo "Setting up port forwarding to Jenkins on port ${port}..."
kubectl port-forward svc/${jenkins_name}-jenkins ${port}:8080 
if [ $? -ne 0 ]; then
  echo "The port ${port} is already in use"
  exit 1
fi
echo "Jenkins is running on port ${port}"
