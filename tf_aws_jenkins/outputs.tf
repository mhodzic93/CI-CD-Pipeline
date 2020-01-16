output "jenkins_ip" {
  value = "${aws_eip.jenkins-eip.public_ip}"
}
