# Terraform AWS VPC, Subnet, Route Table, and EC2 Instance
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = local.application_availability_zones[0]

  tags = {
    Name         = "${var.name_prefix}-public-subnet-${trimprefix(local.application_availability_zones[0], data.aws_region.this.name)}"
    connectivity = "public"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = local.application_availability_zones[1]

  tags = {
    Name         = "${var.name_prefix}-public-subnet-${trimprefix(local.application_availability_zones[1], data.aws_region.this.name)}"
    connectivity = "public"
  }
}

# Create a Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

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

resource "aws_route_table_association" "public_subnet_2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Security Group Creation
resource "aws_security_group" "webserver_security_group" {
  name        = "${var.name_prefix}-webserver-sg"
  description = "Security group for the web server"

  vpc_id = aws_vpc.main_vpc.id

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

# Launch AWS Configuration for EC2 instances
resource "aws_launch_configuration" "web_server" {
  name                        = "${var.name_prefix}-web-server-launch-configuration"
  image_id                    = data.aws_ami.amazon_linux_latest_ami.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.web_server_public_key.key_name
  security_groups             = [aws_security_group.webserver_security_group.id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
  EOF

}

# Set up AWS Autoscaling Group
resource "aws_autoscaling_group" "web_server" {
  name                 = "${var.name_prefix}-web-server-asg"
  vpc_zone_identifier  = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.web_server.id

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.name_prefix}-web-server-ec2"
  }

}

resource "aws_cloudwatch_metric_alarm" "web-server-high-cpu-utilization" {
  alarm_name = "${var.name_prefix}-high-cpu-utilization-alarm"

  namespace  = "AWS/EC2"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_server.name
  }
  metric_name = "CPUUtilization"

  period             = "60"
  evaluation_periods = "5"
  statistic          = "Average"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = "70"

  alarm_description = "Scale up using cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.cpu_scale_up.arn]
}

resource "aws_autoscaling_policy" "cpu_scale_up" {
  autoscaling_group_name = aws_autoscaling_group.web_server.name
  name                   = "${var.name_prefix}-cpu-utilization-scale-up-policy"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  scaling_adjustment     = 1
}

resource "aws_cloudwatch_metric_alarm" "web-server-low-cpu-utilization" {
  alarm_name = "${var.name_prefix}-low-cpu-utilization-alarm"

  namespace  = "AWS/EC2"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_server.name
  }
  metric_name = "CPUUtilization"

  period             = "60"
  evaluation_periods = "10"
  statistic          = "Average"

  comparison_operator = "LessThanThreshold"
  threshold           = "40"

  alarm_description = "Scale down using cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.cpu_scale_down.arn]
}

resource "aws_autoscaling_policy" "cpu_scale_down" {
  autoscaling_group_name = aws_autoscaling_group.web_server.name
  name                   = "${var.name_prefix}-cpu-utilization-scale-down-policy"
  policy_type            = "SimpleScaling"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 600
  scaling_adjustment     = -1
}

# search domain or register domain, if it does not exist
resource "aws_route53domains_registered_domain" "top_level_domain" {
  domain_name = "domainfortesting.link"
}

# creating your hosted zone
resource "aws_route53_zone" "my_public_sub_zone" {
  name = "krishanu.${data.aws_route53_zone.top_level_public_zone.name}"
}

# Sub domain record register
resource "aws_route53_record" "sub_zone_record_register" {
  name            = aws_route53_zone.my_public_sub_zone.name
  type            = "NS"
  zone_id         = data.aws_route53_zone.top_level_public_zone.zone_id
  allow_overwrite = true
  ttl             = 172800
  records         = aws_route53_zone.my_public_sub_zone.name_servers
}

# Create a Route 53 DNS for application
resource "aws_route53_record" "web_server_route53_record" {
  name    = "www.${aws_route53_zone.my_public_sub_zone.name}"
  type    = "A"
  zone_id = aws_route53_zone.my_public_sub_zone.zone_id
  ttl     = "300"
  records = ["35.154.185.152", "3.110.102.121"]

  depends_on = [aws_autoscaling_group.web_server]
}
