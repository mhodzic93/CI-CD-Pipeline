#!/bin/bash

# Install Terraform
xcode-select --install
brew install gcc
brew install tfenv
tfenv install 0.11.14

# Insall docker
brew cask install docker

# Start docker
open --background -a Docker

# make scripts executable
chmod +x plan.sh
chmod +x deploy.sh
chmod +x destroy.sh
