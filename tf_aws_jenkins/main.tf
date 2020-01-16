data "aws_ami" "jenkins" {
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

resource "aws_eip" "jenkins-eip" {
  vpc      = true
  instance = "${aws_instance.jenkins.id}"
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

  vars {
    PASSWORD            = "${var.jenkins_password}"
    USERNAME            = "${var.jenkins_username}"
    S3_BUCKET           = "${var.s3_bucket}"
    PLUGINS_PATH        = "${var.plugins_path}"
    CSRF_PATH           = "${var.csrf_path}"
    DEFAULT_PATH        = "${var.default_path}"
    CREATE_USER_PATH    = "${var.create_user_path}"
    AGENT_SECURITY_PATH = "${var.agent_security_path}"
    CREDS_PATH          = "${var.creds_path}"
    JENKINS_EMAIL       = "${var.jenkins_email}"
    TOMCAT_IP           = "${var.tomcat_ip}"
    TOMCAT_PASSWORD     = "${var.tomcat_password}"
    TOMCAT_USERNAME     = "${var.tomcat_username}"
    CONFIG_PATH         = "${var.config_path}"
    GIT_TOOL_PATH       = "${var.git_tool_path}"
    MAVEN_PATH          = "${var.maven_path}"
  }
}
