data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  common_tags = {
    environment = var.environment_name
    owner       = var.owner_name
    ttl         = var.ttl
  }

  ami_id         = var.ami_id == null ? data.aws_ami.ubuntu.id : var.ami_id
}

resource "aws_instance" "main" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = var.associate_public_ip_address
  root_block_device {
    volume_type = "gp2"
  }

  tags = merge(local.common_tags, var.tags == null ? {} : var.tags, { Name = var.name })
}
