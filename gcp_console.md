# GCP INSTANCE
## CONFIG
INSTANCE
ubuntu-minimal-2510-questing-amd64-v20251217

NETWORK TAG:vscode-server-8080

FIREWALL:
Name: vscode-server-8080

Target tags: vscode-server

Source filters IP ranges 0.0.0.0/0

## ACCESS
export REMOTE=34.116.195.168

ssh -p 22 strongfrakk@${REMOTE}

## COPY SOMETHING
scp init.sh strongfrakk@${REMOTE}:/home/strongfrakk

# HOST
## CONFIG
sudo apt update -y

sudo apt upgrade -y

sudo apt install -y git curl zip unzip ca-certificates gnupg lsb-release 

### VSCODE
sudo apt install code

### DOCKER
install_docker_ubuntu.sh

## CODESERVER - SEE ACCESS
// password

cat /home/strongfrakk/.config/code-server/config.yaml

// to access from browser 1/2

code-server --bind-addr 0.0.0.0:8080

// to access from browser 2/2

ssh -L 8080:localhost:8080 user@szerver`

// browser

http://localhost:8080

### VSCODE JAVA DEVELOPMENT PLUGINS

https://code.visualstudio.com/docs/languages/java

Language Support for Java™ by Red Hat

Debugger for Java

Test Runner for Java

Maven for Java

Project Manager for Java

Visual Studio IntelliCode

