#!/bin/bash

# Install and upgrade packages
yum remove java -y
yum update -y
yum install -y python-pip wget
pip install --upgrade awscli

# Install Java
yum install -y java-1.8.0-openjdk

cat <<EOF >> /etc/profile
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-1.el8_0.x86_64
export PATH=$PATH:$JAVA_HOME
EOF
source /etc/profile

# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins

# Start Jenkins
service jenkins start
chkconfig jenkins on
