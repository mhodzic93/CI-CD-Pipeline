output "bastion_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "bastion_sg" {
  value = "${aws_security_group.bastion.id}"
}

output "bastion_role" {
  value = "${aws_iam_role.bastion.name}"
}
