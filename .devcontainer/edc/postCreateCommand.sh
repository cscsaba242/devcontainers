#!/bin/bash
SECONDS=0
client=/workspaces/devcontainers/.devcontainer/edc
echo "SETTING PROXIES"
cp "${client}/95proxies" /etc/apt/apt.conf.d/95proxies
cp "${client}/gradle.properties" "/workspaces/devcontainers/Connector"
apt-get update
apt-get install -y docker.io curl build-essential git libssl-dev libdbus-1-dev pkg-config unzip zip mitmproxy vim net-tools tmux tcpdump lsof
git config --global --add safe.directory /workspaces/devcontainers/edcconnectoradapter


curl -s "https://get.sdkman.io" | bash
echo 'source "$HOME/.sdkman/bin/sdkman-init.sh"' >> ~/.bashrc
source "$HOME/.sdkman/bin/sdkman-init.sh"
cp "$client/.devcontainer/.sdkmanrc" "$client/.sdkmanrc"
sdk env install
cp $client/.devcontainer/smpl_edcadapter/.settings.xml $HOME/.m2/settings.xml
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


