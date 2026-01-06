#!/bin/bash
SECONDS=0
client=/workspaces/devcontainers/.devcontainer/edc
echo "SETTING PROXIES"
cp "${client}/95proxies" /etc/apt/apt.conf.d/95proxies
cp "${client}/gradle.properties" "/workspaces/devcontainers/Connector"
apt-get update
apt-get install -y docker.io curl build-essential git libssl-dev libdbus-1-dev pkg-config unzip zip mitmproxy vim net-tools tmux tcpdump lsof

#curl -Lo helm.tar.gz https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz
#tar -xzf helm.tar.gz
#mv linux-amd64/helm /usr/local/bin/helm
#rm -rf linux-amd64 helm.tar.gz
#curl -LO https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl
#chmod +x kubectl
#mv kubectl /usr/local/bin/kubectl
#curl -Lo kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
#chmod +x kind
#mv kind /usr/local/bin/kind
#curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_Linux_amd64.tar.gz
#tar -xzf k9s.tar.gz
#chmod +x k9s
#mv k9s /usr/local/bin/k9s
#rm k9s.tar.gz

# curl https://sh.rustup.rs -sSf | sh
# echo 'source $HOME/.cargo/env' >> ~/.bashrc
# source $HOME/.cargo/env
# cargo install edc-connector-tui

curl -s "https://get.sdkman.io" | bash
echo 'source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.bashrc
source "$HOME/.sdkman/bin/sdkman-init.sh"
cp "$client/.devcontainer/.sdkmanrc" "$client/.sdkmanrc"
sdk env install
curl https://logdy.dev/install-silent.sh | sh

helm version
docker version | grep "Version" | head -n 1

cd ./Connector
./gradlew

echo "source /workspaces/devcontainers/.devcontainer/include_bash.sh" >> ~/.bashrc
source ~/.bashrc

echo "Runtime: ${SECONDS}s"

# tmux new-session -n server 'bash' \; \
#   new-window -n mitmproxy 'mitmproxy -p 8888' \; \
#   new-window -n top 'top' \; \
#   new-window -n tail 'tail -fn 200 ./Connector/last.log' \;


