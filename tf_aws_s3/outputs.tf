output "devops_bucket" {
  value = "${aws_s3_bucket.devops.bucket}"
}

output "plugins_path" {
  value = "${aws_s3_bucket_object.jenkins_plugins.key}"
}

output "csrf_path" {
  value = "${aws_s3_bucket_object.csrf.key}"
}

output "default_path" {
  value = "${aws_s3_bucket_object.default.key}"
}

output "create_user_path" {
  value = "${aws_s3_bucket_object.create_user.key}"
}

output "agent_security_path" {
  value = "${aws_s3_bucket_object.agent_security.key}"
}

output "context_path" {
  value = "${aws_s3_bucket_object.context.key}"
}

output "config_path" {
  value = "${aws_s3_bucket_object.config.key}"
}

output "git_tool_path" {
  value = "${aws_s3_bucket_object.git_tool.key}"
}

output "maven_path" {
  value = "${aws_s3_bucket_object.maven.key}"
}

output "tomcat_users_path" {
  value = "${aws_s3_bucket_object.tomcat_users.key}"
}

output "creds_path" {
  value = "${aws_s3_bucket_object.creds.key}"
}
