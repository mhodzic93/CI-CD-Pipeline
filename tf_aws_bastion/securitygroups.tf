resource "aws_security_group" "bastion" {
  name        = "tf-${var.stack_name}-bastion-sg"
  description = "Allow SSH from specified public IP address, all egress"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.public_ip}"]
    self        = false
    description = "Allow SSH from specified public IP address"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "tf-${var.stack_name}-bastion-sg"
  }
}
