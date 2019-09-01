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
  ssh_public_key = var.ssh_public_key == null ? var.ssh_public_key_name : aws_key_pair.main[0].key_name
}

resource "aws_key_pair" "main" {
  key_name   = "${local.common_tags.environment}-${var.name}-key"
  public_key = "${var.ssh_public_key}"
}


resource "aws_instance" "main" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = var.instance_type
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = local.ssh_public_key
  user_data                   = var.user_data
  associate_public_ip_address = var.associate_public_ip_address
  root_block_device {
    volume_type = "gp2"
  }

  tags = merge(local.common_tags, var.tags == null ? {} : var.tags, { Name = var.name })
}
