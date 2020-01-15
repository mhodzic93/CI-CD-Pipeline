resource "aws_s3_bucket" "jenkins" {
  bucket = "tf-${var.stack_name}-jenkins-${var.region}"
  region = "${var.region}"
}

resource "aws_s3_bucket_object" "jenkins_plugins" {
  bucket = "${aws_s3_bucket.jenkins.bucket}"
  key    = "jenkins/plugins.txt"
  source = "${path.root}/scripts/plugins.txt"
}

resource "aws_s3_bucket_object" "agent_security" {
  bucket = "${aws_s3_bucket.jenkins.bucket}"
  key    = "jenkins/agent_security.groovy"
  source = "${path.root}/scripts/agent_security.groovy"
}

resource "aws_s3_bucket_object" "create_user" {
  bucket = "${aws_s3_bucket.jenkins.bucket}"
  key    = "jenkins/create_user.groovy"
  source = "${path.root}/scripts/create_user.groovy"
}

resource "aws_s3_bucket_object" "csrf" {
  bucket = "${aws_s3_bucket.jenkins.bucket}"
  key    = "jenkins/csrf.groovy"
  source = "${path.root}/scripts/csrf.groovy"
}

resource "aws_s3_bucket_object" "default" {
  bucket = "${aws_s3_bucket.jenkins.bucket}"
  key    = "jenkins/default.groovy"
  source = "${path.root}/scripts/default.groovy"
}
