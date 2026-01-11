#!/bin/bash
SECONDS=0 
export CLIENT_DIR="/workspaces/devcontainers/.devcontainer/data1"
echo "SETTING PROXIES:" $CLIENT_DIR

cp "${CLIENT_DIR}/95proxies" /etc/apt/apt.conf.d/95proxies
apt-get update
apt-get install -y docker.io curl build-essential git libssl-dev libdbus-1-dev pkg-config unzip zip mitmproxy vim net-tools tmux tcpdump lsof systemd mc
git config --global --add safe.directory "/workspaces"


curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# echo "helm"
# curl -Lo helm.tar.gz https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz
# tar -xzf helm.tar.gz
# mv linux-amd64/helm /usr/local/bin/helm
# rm -rf linux-amd64 helm.tar.gz
#  
# echo "kubectl"
# curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl
# chmod +x kubectl
# mv kubectl /usr/local/bin/kubectl
#  
# echo "kind"
# curl -Lo kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
# chmod +x kind
# mv kind /usr/local/bin/kind
#  
# echo "k9s"
# curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_Linux_amd64.tar.gz
# tar -xzf k9s.tar.gz
# chmod +x k9s
# mv k9s /usr/local/bin/k9s
# rm k9s.tar.gz
# 
 # echo "cargo"
 # curl https://sh.rustup.rs -sSf | sh
 # echo 'source $HOME/.cargo/env' >> ~/.bashrc
 # source $HOME/.cargo/env
 # cargo install edc-connector-tui
 
echo "sdkman"
curl -s "https://get.sdkman.io" | bash
echo 'source "/usr/local/sdkman/bin/sdkman-init.sh"' >> ~/.bashrc
source "/usr/local/sdkman/bin/sdkman-init.sh"
cp ${CLIENT_DIR}/.sdkmanrc $HOME
cd $HOME
sdk env install

export MAVEN_HOME="$HOME/.sdkman/candidates/maven/current"
export PATH="$MAVEN_HOME/bin:$PATH"

export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export PATH="$JAVA_HOME/bin:$PATH"

mvn -version
cp $CLIENT_DIR/.settings.xml $HOME/.m2/settings.xml
echo "logdy"
curl https://logdy.dev/install-silent.sh | sh

echo "source ${CLIENT_DIR}/include_bash_profile.sh" >> ~/.bashrc
source ~/.bashrc

cd $HOME
# Download latest Taskfile release
curl -sL https://github.com/go-task/task/releases/latest/download/task_linux_amd64.tar.gz -o task.tar.gz

# Extract binary
tar -xzf task.tar.gz

# Move to PATH
sudo mv task /usr/local/bin/

# Cleanup
rm task.tar.gz
