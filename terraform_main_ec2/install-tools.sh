#!/bin/bash

sudo dnf update -y

# ---------------- GIT ----------------
sudo dnf install git -y

# ---------------- JAVA (dla Jenkins) ----------------
sudo dnf install java-17-amazon-corretto -y

# ---------------- JENKINS ----------------
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

# ---------------- TERRAFORM ----------------
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo dnf install terraform -y

# ---------------- MAVEN ----------------
sudo dnf install maven -y

# ---------------- DOCKER ----------------
sudo dnf install docker -y
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins

sudo chmod 666 /var/run/docker.sock

# ---------------- KUBECTL ----------------
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# ---------------- EKSCTL ----------------
curl --silent --location \
"https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
| tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

# ---------------- HELM ----------------
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# ---------------- TRIVY ----------------
sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.49.1_Linux-64bit.rpm

# ---------------- SONARQUBE (Docker) ----------------
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

# ---------------- ARGOCD ----------------
kubectl create namespace argocd

kubectl apply -n argocd -f \
https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# ---------------- PROMETHEUS + GRAFANA ----------------
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

kubectl create namespace monitoring

helm install monitoring prometheus-community/kube-prometheus-stack \
-n monitoring

# ---------------- MARIADB ----------------
sudo dnf install mariadb105-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb

# ---------------- AWS CLI ----------------
sudo dnf install unzip -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

echo "Installation completed successfully."