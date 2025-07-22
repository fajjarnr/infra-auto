locals {
  ami_ids = {
    "ubuntu"       = data.aws_ami.ubuntu.id
    "amazon_linux" = data.aws_ami.amazon_linux.id
    "rhel9"        = data.aws_ami.rhel9.id
  }
}

resource "aws_instance" "main" {
  ami                         = var.ami_id != "" ? var.ami_id : local.ami_ids[var.os_name]
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  tags = {
    Name = var.instance_name
  }
}
