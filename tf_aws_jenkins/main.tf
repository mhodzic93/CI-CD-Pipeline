data "aws_ami" "jenkins" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-2018.03.0.20190826-x86_64-gp2*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_eip" "jenkins-eip" {
  vpc      = true
  instance = "${aws_instance.jenkins.id}"

  depends_on = ["aws_eip.jenkins-eip"]
}

resource "aws_instance" "jenkins" {
  ami                         = "${data.aws_ami.jenkins.image_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.jenkins.id}"]
  subnet_id                   = "${var.public_subnet}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  source_dest_check           = "${var.source_dest_check}"
  iam_instance_profile        = "${aws_iam_instance_profile.jenkins_profile.name}"
  user_data                   = "${data.template_file.userdata.rendered}"

  tags = {
    Name        = "tf-${var.stack_name}-jenkins"
    Subnet      = "public"
    Environment = "${var.environment_type}"
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"
}
