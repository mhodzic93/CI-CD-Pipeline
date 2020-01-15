output "JENKINS_URL" {
  value = "http://${module.jenkins.jenkins_ip}:8080"
}
