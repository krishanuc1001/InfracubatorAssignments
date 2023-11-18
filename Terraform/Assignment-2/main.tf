# Terraform AWS VPC, Subnet, Route Table, and EC2 Instance
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.16.0/20"

  tags = {
    Name         = "${var.name_prefix}-public-subnet-1"
    connectivity = "public"
  }
}

# Create a Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name_prefix}-public-route-table"
  }
}

# Create a Route Table Association for the Public Subnet
resource "aws_route_table_association" "public_subnet_1_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Security Group Creation
resource "aws_security_group" "webserver_security_group" {
  name        = "${var.name_prefix}-webserver-sg"
  description = "Security group for the web server"

  vpc_id = aws_vpc.main.id

  # Define inbound rules for SSH and HTTP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"] # For SSH (adjust for security)
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # For HTTP (adjust for security)
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name_prefix}-webserver-sg"
  }
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "local_file" "private_key_file" {
  filename        = "ec2.pem"
  file_permission = "400"
  content         = tls_private_key.private_key.private_key_pem
}

resource "aws_key_pair" "web_server_public_key" {
  key_name   = "${var.name_prefix}-web-server-public-key"
  public_key = tls_private_key.private_key.public_key_openssh

  tags = {
    Name = "${var.name_prefix}-web-server-public-key"
  }
}

# Launch an EC2 Instance
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.amazon_linux_latest_ami.id # Replace with your desired AMI ID
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.web_server_public_key.key_name
  associate_public_ip_address = true

  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.webserver_security_group.id]

  # Use provisioners to install Apache2
  connection {
    type        = "ssh"
    user        = "ec2-user" # For Amazon Linux 2
    private_key = tls_private_key.private_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }

  tags = {
    Name = "${var.name_prefix}-web-server"
  }
}

# Output Variable Configuration
output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}