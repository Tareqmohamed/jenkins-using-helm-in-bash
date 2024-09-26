
# Jenkins Helm Installation Script

This script automates the process of setting up Jenkins on a Kubernetes cluster running in Minikube, using Helm. It includes steps for checking Minikube status, adding the Jenkins Helm repository, installing Jenkins, and setting up port forwarding.

## Prerequisites

Ensure you have the following installed before running the script:
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm](https://helm.sh/docs/intro/install/)

## Usage

Clone this repository and run the script as follows:

```bash
sudo chmod +x ./jenkins-helm.sh
./jenkins-helm.sh [jenkins_name] [port]
```

### Parameters:
- `jenkins_name` (optional): The name to assign to the Jenkins Helm release. Defaults to `"my-jenkins"`.
- `port` (optional): The port to use for Jenkins' external access. Defaults to `8089`.

### Example:

```bash
./jenkins-helm.sh my-jenkins 8090
```

This will deploy Jenkins under the release name `my-jenkins` and expose it on port `8090`.

## Script Details

### What the script does:
1. **Check Minikube Status**: Ensures that Minikube is running. If it's not, it will attempt to start Minikube.
2. **Helm Repository Setup**: Checks if the Jenkins Helm repository is added. If not, it adds the Jenkins repository and updates it.
3. **Install Jenkins**: Installs Jenkins using Helm, if it’s not already installed.
4. **Check Jenkins Pod**: Ensures that the Jenkins pod is running.
5. **Fetch Admin Password**: Retrieves the initial admin password required for logging into Jenkins.
6. **Port Forwarding**: Sets up port forwarding to access Jenkins via the specified port on your local machine.

### Notes:

- By default, the script installs Jenkins version `5.7.0`.
- If the port you specify is already in use, the script will terminate with an error.
- Make sure your environment supports running Kubernetes and Helm.

### Example Output

Upon successful execution, the script will provide output similar to the following:

```
Minikube is running
Jenkins Helm repo is already added
Jenkins is already installed
Jenkins is running
Fetching Jenkins initial admin password...
Setting up port forwarding to Jenkins on port 8089...
Jenkins is running on port 8089
```

## Troubleshooting

- **Minikube is not running**: If Minikube fails to start, ensure your local environment can support virtualization or try restarting Minikube manually with `minikube start`.
- **Helm is not installed**: Install Helm by following the [official documentation](https://helm.sh/docs/intro/install/).
- **Port conflicts**: If the specified port is already in use, try changing it to a different port or stopping other services that might be using the port.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
