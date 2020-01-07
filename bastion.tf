module "bastion" {
  source                      = "tf_aws_bastion"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  cidr                        = "${var.cidr}"
  environment_type            = "${var.environment_type}"
  instance_type               = "${lookup(var.instance_size, "bastion")}"
  key_name                    = "${var.key_name}"
  public_ip                   = "${var.public_ip}"
  public_subnet               = "${var.public_subnet}"
  region                      = "${var.region}"
  source_dest_check           = "${var.source_dest_check}"
  stack_name                  = "${var.stack_name}"
  vpc_id                      = "${var.vpc_id}"
}
