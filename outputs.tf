output "JENKINS_URL" {
  value = "http://${module.jenkins.jenkins_ip}:8080"
}

output "TOMCAT_URL" {
  value = "http://${module.tomcat.tomcat_ip}:8080"
}

output "DEVOPS_BUCKET" {
  value = "${module.s3.devops_bucket}"
}