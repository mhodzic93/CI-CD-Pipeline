#!/bin/bash

if [ -z "${1}" ]; then
    echo "Please specify an aws profile in argument 1 for this script"
    exit 1
fi

export AWS_ACCESS_KEY_ID=$(aws configure get ${1}.aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get ${1}.aws_secret_access_key)

echo "Deploying terraform"
terraform apply plan.out
