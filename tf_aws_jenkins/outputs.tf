output "jenkins_ip" {
  value = "${aws_eip.jenkins-eip.public_ip}"
}

output "jenkins_sg" {
  value = "${aws_security_group.jenkins.id}"
}

output "jenkins_role" {
  value = "${aws_iam_role.jenkins.name}"
}
