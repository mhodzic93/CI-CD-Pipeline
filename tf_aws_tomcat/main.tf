data "aws_ami" "tomcat" {
  most_recent = true
  owners      = ["amazon"]

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

resource "aws_eip" "tomcat-eip" {
  vpc      = true
  instance = "${aws_instance.tomcat.id}"
}

resource "aws_instance" "tomcat" {
  ami                         = "${data.aws_ami.tomcat.image_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.tomcat.id}"]
  subnet_id                   = "${var.public_subnet}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  source_dest_check           = "${var.source_dest_check}"
  iam_instance_profile        = "${aws_iam_instance_profile.tomcat_profile.name}"
  user_data                   = "${data.template_file.userdata.rendered}"

  tags = {
    Name        = "tf-${var.stack_name}-tomcat"
    Subnet      = "public"
    Environment = "${var.environment_type}"
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.tpl")}"

  vars {
    CONTEXT_PATH      = "${var.context_path}"
    PASSWORD          = "${var.tomcat_password}"
    S3_BUCKET         = "${var.s3_bucket}"
    TOMCAT_USERS_PATH = "${var.tomcat_users_path}"
    USERNAME          = "${var.tomcat_username}"
  }
}
