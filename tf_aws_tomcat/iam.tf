resource "aws_iam_instance_profile" "tomcat_profile" {
  name = "tomcat-${var.stack_name}-profile"
  role = "${aws_iam_role.tomcat.name}"
}

resource "aws_iam_role" "tomcat" {
  name = "tomcat-${var.stack_name}"

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

resource "aws_iam_policy" "tomcat" {
  name        = "tomcat-${var.stack_name}_policy"
  path        = "/"
  description = "tomcat-${var.stack_name}_policy"
  policy      = "${data.template_file.iam.rendered}"
}

data "template_file" "iam" {
  template = "${file("${path.module}/iam.tpl")}"
}

resource "aws_iam_policy_attachment" "tomcat-attach" {
  name       = "tomcat-${var.stack_name}_attach"
  roles      = ["${aws_iam_role.tomcat.name}"]
  policy_arn = "${aws_iam_policy.tomcat.arn}"
}
