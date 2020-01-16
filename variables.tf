# General Variables

variable "account_id" {
  description = "Sets the aws account id the infrastructure is deployed in"
}

variable "cidr" {
  description = "Sets the cidr block of the VPC"
}

variable "environment_type" {
  description = "Sets the environment being deployed"
}

variable "jenkins_email" {
  description = "Sets the email of the Jenkins server"
}

variable "jenkins_password" {
  description = "Sets the Jenkins user's password"
}

variable "jenkins_username" {
  description = "Sets the Jenkins username"
}

variable "key_name" {
  description = "Sets the ec2 key pair name used on the ecs host instances"
}

variable "public_ip" {
  description = "Sets the public ip that is allowed to connect to the instances using SSH"
}

variable "public_subnet" {
  description = "Sets the public subnet that the ecs hosts are using"
}

variable "region" {
  description = "Sets the aws region where the infrastructure is deployed"
}

variable "stack_name" {
  description = "Sets the name of the stack"
}

variable "tomcat_password" {
  description = "Sets the Tomcat user's password"
}

variable "tomcat_username" {
  description = "Sets the Tomcat username"
}

variable "vpc_id" {
  description = "Sets the vpc id that the resources are using"
}

# EC2 Variables

variable "instance_size" {
  description = "Sets the instance size per resource"
  type        = "map"

  default = {
    jenkins = "t2.medium"
    tomcat  = "t2.medium"
  }
}

variable "associate_public_ip_address" {
  description = "Sets whether the instance has a public ip address"
  default     = true
}

variable "source_dest_check" {
  description = "Sets whether the network interface performs source/destination checking"
  default     = false
}
