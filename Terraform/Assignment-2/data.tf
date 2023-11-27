data "aws_ami" "amazon_linux_latest_ami" {
  owners = ["amazon"]
  most_recent = true
  name_regex = "^al2023-ami-\\d{4}\\.\\d\\.\\d{8}.\\d-kernel-6\\.1-x86_64"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "ena-support"
    values = [true]
  }
}

data "http" "my_ip" {
  url = "https://ifconfig.co/"
}

data "aws_availability_zones" "all_availability_zones" {
  state = "available"
}

data "aws_region" "this" {}

locals {
  application_availability_zones = slice(data.aws_availability_zones.all_availability_zones.names, 0, 2)
}

# searching for top level domain hosted zone
data "aws_route53_zone" "top_level_public_zone" {
  name = "${aws_route53domains_registered_domain.top_level_domain.domain_name}."
}