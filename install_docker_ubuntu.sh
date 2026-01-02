#!/bin/bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io


arch=$(dpkg --print-architecture)
name=$(lsb_release -cs)

echo "arch:"$arch
echo "name:"$name

echo "deb [arch=$arch signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$name stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

cd /etc/apt
ls -al ./sources.list.d/docker.list
ls -al ./keyrings/docker.gpg
