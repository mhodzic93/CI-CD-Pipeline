resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion-${var.stack_name}-profile"
  role = "${aws_iam_role.bastion.name}"
}

resource "aws_iam_role" "bastion" {
  name = "bastion-${var.stack_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
	}
  ]
}
EOF
}

resource "aws_iam_policy" "bastion" {
  name        = "bastion-${var.stack_name}_policy"
  path        = "/"
  description = "bastion-${var.stack_name}_policy"
  policy      = "${data.template_file.iam.rendered}"
}

data "template_file" "iam" {
  template = "${file("${path.module}/iam.tpl")}"
}

resource "aws_iam_policy_attachment" "bastion-attach" {
  name       = "bastion-${var.stack_name}_attach"
  roles      = ["${aws_iam_role.bastion.name}"]
  policy_arn = "${aws_iam_policy.bastion.arn}"
}
