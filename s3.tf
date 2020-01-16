module "s3" {
  source                      = "tf_aws_s3"
  region                      = "${var.region}"
  stack_name                  = "${var.stack_name}"
}
