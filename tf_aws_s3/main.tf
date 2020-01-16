resource "aws_s3_bucket" "devops" {
  bucket = "tf-${var.stack_name}-devops-${var.region}"
  region = "${var.region}"
}

resource "aws_s3_bucket_object" "jenkins_plugins" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/plugins.txt"
  source = "${path.root}/scripts/jenkins/plugins.txt"
}

resource "aws_s3_bucket_object" "csrf" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/csrf.groovy"
  source = "${path.root}/scripts/jenkins/csrf.groovy"
}

resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/default.groovy"
  source = "${path.root}/scripts/jenkins/default.groovy"
}

resource "aws_s3_bucket_object" "create_user" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/create_user.groovy"
  source = "${path.root}/scripts/jenkins/create_user.groovy"
}

resource "aws_s3_bucket_object" "agent_security" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/agent_security.groovy"
  source = "${path.root}/scripts/jenkins/agent_security.groovy"
}

resource "aws_s3_bucket_object" "creds" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/creds.groovy"
  source = "${path.root}/scripts/jenkins/creds.groovy"
}

resource "aws_s3_bucket_object" "config" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/config.xml"
  source = "${path.root}/scripts/jenkins/config.xml"
}

resource "aws_s3_bucket_object" "git_tool" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/hudson.plugins.git.GitTool.xml"
  source = "${path.root}/scripts/jenkins/hudson.plugins.git.GitTool.xml"
}

resource "aws_s3_bucket_object" "maven" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "jenkins/hudson.tasks.Maven.xml"
  source = "${path.root}/scripts/jenkins/hudson.tasks.Maven.xml"
}

resource "aws_s3_bucket_object" "context" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "tomcat/context.xml"
  source = "${path.root}/scripts/tomcat/context.xml"
}

resource "aws_s3_bucket_object" "tomcat_users" {
  bucket = "${aws_s3_bucket.devops.bucket}"
  key    = "tomcat/tomcat_users.xml"
  source = "${path.root}/scripts/tomcat/tomcat_users.xml"
}
