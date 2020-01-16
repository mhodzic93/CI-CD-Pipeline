#!/bin/bash

# Install Terraform
xcode-select --install
brew install gcc
brew install tfenv
tfenv install 0.11.14

# Install git
git --version
if [ "$?" -eq 0 ]; then
  echo "Git is already installed, continuing..."
  exit 0
else
  echo "Git not found, installing..."
  brew install git
fi

# Insall docker
brew cask install docker

# Start docker
open --background -a Docker

# make scripts executable
chmod +x plan.sh
chmod +x deploy.sh
chmod +x destroy.sh
