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