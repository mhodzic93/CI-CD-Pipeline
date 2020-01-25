#!/bin/bash

# Install Terraform
apt install -y gcc unzip
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
. ~/.bash_profile
tfenv install 0.11.14

# Insall docker
apt remove -y docker docker-engine docker.io
apt install -y docker.io

# Start docker
systemctl start docker
systemctl enable docker

# make scripts executable
chmod +x plan.sh
chmod +x deploy.sh
chmod +x destroy.sh
