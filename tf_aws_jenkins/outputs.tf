output "jenkins_ip" {
  value = "${aws_instance.jenkins.public_ip}"
}

output "jenkins_sg" {
  value = "${aws_security_group.jenkins.id}"
}

output "jenkins_role" {
  value = "${aws_iam_role.jenkins.name}"
}
