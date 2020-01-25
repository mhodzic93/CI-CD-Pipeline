# Jenkins
Builds a Jenkins server running on AWS and deploys
a Tomcat server using Terraform

# Requirements
1. Create an AWS account.

2. Create an IAM user, assign the user `Programmatic access`, attach the `AdministratorAccess` IAM policy to the user, and 
save the access key ID and secret access key ID.

3. Install the pre-reqs by running the following commands:

##### Mac OS:
```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Install git
git --version
if [ "$?" -eq 0 ]; then
  echo "Git is already installed, continuing..."
  exit 0
else
  echo "Git not found, installing..."
  brew install git
fi

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

```

##### Linux(Ubuntu):
```
apt update -y
apt install -y curl python git
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
apt install -y python-pip awscli
```

4. Configure your aws profile locally by running the below command and filling out the
parameters using the keys saved from step 2:
`aws configure`

5. Import a key pair to the EC2 service in the region you will be deploying in or create
a key pair, if you don't already have an ssh key.

6. Clone the repository locally, by running:
`git clone https://github.com/mhodzic93/CI-CD-Pipeline.git`

7. Copy the `manifest.tfvars.tpl` file to the root directory and name it `manifest.tfvars`.
If you're not sure what the values should look like, view the `manifest.tfvars.example` file.
Update the following variables in the `manifest.tfvars` file:
```
account_id - set this to your AWS account id
cidr - set this to the cidr block of your default vpc
environment_type - set this to the environment type you are running
key_name - set this to the name of the key pair you generated in step 5
jenkins_email - set this to an email address that will administer Jenkins
jenkins_password - set this to the password of the jenkins user
jenkins_username - set this to the username of the jenkins user
public_ip - set this to your public ip using this format: 1.1.1.1/32
public_subnet - set this to one of the default subnet id's that exist in the region you are deploying in 
region - set this to the region you are deploying in
stack_name - set this to the stack name of your choosing
tomcat_password - set this to the password of the tomcat user
tomcat_username - set this to the username of the tomcat user
vpc_id - set this to the default vpc id in region you are deploying in

```


7. Run the requirements install script to install the required tools:
##### MacOS:
```
chmod +x ./scripts/mac_requirements.sh
./scripts/mac_requirements.sh
```

##### Linux(Ubuntu):
```
chmod +x ./scripts/linux_requirements.sh
./scripts/linux_requirements.sh
```

# Running Terraform

Replace `<path_to_variables_file>` with the path to the `manifest.tfvars` file.

Replace `<aws_profile>` with the aws profile name.

Run the Terraform plan script to get a plan of the infrastructure that will be deployed:
```
./plan.sh <path_to_variables_file> <aws_profile>
```

Once you have ran the Terraform plan script, run the Terraform deploy script to deploy the infrastructure:
```
./deploy.sh <aws_profile>
```

# Viewing the solution
Note: It can take up to 10 minutes for Jenkins to fully deploy from the time you ran the deploy script.

To view the solution, follow the steps below:
1. When you run the `deploy.sh` script you will see the `JENKINS_URL` and `TOMCAT_URL` output. 
2. Navigate to the value of the `JENKINS_URL` and login to Jenkins using the `jenkins_username` and `jenkins_password` values
that you set in the `manifest.tfvars` file.
3. Select the `Deploy_Tomcat` job in the jenkins job view. This job is configured to poll the scm every minute so it will run within
a minute of Jenkins starting. If the job hasn't ran, select `Build Now` to run the job.
4. Once the job has ran, navigate to `TOMCAT_URL/webapp`, ex. `http://1.1.1.1:8080/webapp`. You will see that the war was successfully
deployed on Tomcat.
5. To test the pipeline, follow the steps below:
    a. Fork the `https://github.com/mhodzic93/hello-world.git` repository
    b. Update the jenkins job to use the new (forked) repository URL by navigating to 
       `JENKINS_URL/job/Deploy_Tomcat/configure` -> `Source Code Management` -> `Git` -> `Repository URL`
    c. Update the `hello-world/webapp/src/main/webapp/index.jsp` file in the forked repository, commit and push the changes
    d. Navigate to Jenkins and wait for the pipeline to deploy, it should deploy within one minute
    e. After the pipeline has deployed, navigate to `TOMCAT_URL/webapp` and verify that the new war has been deployed

# Destroying Terraform
Once you have no further need for the infrastructure, run the Terraform destroy script to destroy the deployed infrastructure:
```
./destroy.sh <path_to_variables_file> <aws_profile>
```

# Improvements
1. Build own VPC
2. Decouple Jenkins from other infrastructure
3. Containerize Tomcat