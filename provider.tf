provider "aws" {
  region      = "${var.region}"
  version     = "2.24.0"
  max_retries = "50"
}
