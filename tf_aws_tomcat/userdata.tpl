#!/bin/bash

# Set hostname
hostname tomcat

# Install and upgrade packages
yum update -y
yum install -y wget
pip install --upgrade awscli

# Install and Configure Tomcat
wget -O /opt/apache-tomcat-8.5.35.tar.gz https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz
tar -xvzf /opt/apache-tomcat-8.5.35.tar.gz  -C /opt
mv /opt/apache-tomcat-8.5.35 /opt/tomcat
rm -f /opt/apache-tomcat-8.5.35.tar.gz

chmod +x /opt/tomcat/bin/startup.sh
chmod +x /opt/tomcat/bin/shutdown.sh

ln -s /opt/tomcat/bin/startup.sh /usr/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/bin/tomcatdown

for folder in manager host-manager;
do
    aws s3 cp s3://${S3_BUCKET}/${CONTEXT_PATH} /opt/tomcat/webapps/$folder/META-INF/context.xml
done

aws s3 cp s3://${S3_BUCKET}/${TOMCAT_USERS_PATH} /opt/tomcat/conf/tomcat-users.xml
sed -i -e 's|{{USERNAME}}|${USERNAME}|g' \
       -e 's|{{PASSWORD}}|${PASSWORD}|' /opt/tomcat/conf/tomcat-users.xml

# Start tomcat
tomcatup
