#!/bin/bash

if [ -z "${1}" ]; then
    echo "Please specify a variables file in argument 1 for this script"
    exit 1
fi

if [ ! -e "${1}" ]; then
    echo "Could not locate variables file: ${1}, specify the proper location"
    exit 1
fi

if [ -z "${2}" ]; then
    echo "Please specify an aws profile in argument 2 for this script"
    exit 1
fi

export AWS_ACCESS_KEY_ID=$(aws configure get ${2}.aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get ${2}.aws_secret_access_key)

while read line;
do
    export $(echo $line | tr -d "\"")
done < ${1}

echo "Starting terraform"
terraform destroy -force -var-file="${1}"

echo "Deleting remote state S3 bucket"
bucket_exists=$(aws s3 ls | grep ${stack_name}-state-bucket-${region})
if [[ -n "${bucket_exists}" ]]; then
    echo "Bucket exists, deleting bucket."
    aws s3 rb s3://${stack_name}-state-bucket-${region} --region ${region} --force
  else
    echo "Bucket does not exist or permission is not there to view it."
fi
