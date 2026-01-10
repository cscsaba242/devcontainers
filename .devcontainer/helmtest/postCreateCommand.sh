#!/bin/bash
SECONDS=0 
client=/workspaces/devcontainers/.devcontainer/helmtest
echo "SETTING PROXIES"

cp "${client}/95proxies" /etc/apt/apt.conf.d/95proxies
apt-get update
apt-get install -y docker.io curl build-essential git libssl-dev libdbus-1-dev pkg-config unzip zip mitmproxy vim net-tools tmux tcpdump lsof systemd mc tree
git config --global --add safe.directory "/workspaces"

echo "helm"
curl -Lo helm.tar.gz https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz
tar -xzf helm.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64 helm.tar.gz
 
echo "kubectl"
curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl
 
echo "kind"
curl -Lo kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
chmod +x kind
mv kind /usr/local/bin/kind
 
echo "k9s"
curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_Linux_amd64.tar.gz
tar -xzf k9s.tar.gz
chmod +x k9s
mv k9s /usr/local/bin/k9s
rm k9s.tar.gz
 
echo "logdy"
curl https://logdy.dev/install-silent.sh | sh

helm version
docker version | grep "Version" | head -n 1

echo "source $client/include_bash_profile.sh" >> ~/.bashrc
source ~/.bashrc

echo "Runtime: ${SECONDS}s"

