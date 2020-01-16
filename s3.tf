module "s3" {
  source        = "tf_aws_s3"
  force_destroy = "${var.force_destroy}"
  region        = "${var.region}"
  stack_name    = "${var.stack_name}"
}
