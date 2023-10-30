## Assignment-1

### Infrastructure Provisioning and Web Server Deployment using Terraform

Objective:
Your task is to use Terraform to provision a Virtual Private Cloud (VPC) on AWS, create a public subnet, set up an Internet Gateway (IGW), configure a routing table, and launch an EC2 instance as a web server. Additionally, you will automatically install Apache2 on the EC2 instance during provisioning. You must ensure secure access to the web server using your SSH key pair and create an output variable to display the public IP address of the web server.

Instructions:
1. Create VPC:
   Use Terraform to define and create an AWS Virtual Private Cloud (VPC) with a specified CIDR block.
   Ensure that the VPC is named appropriately
2. Configure Internet Gateway (IGW):
   Create an Internet Gateway and attach it to the VPC.
3. Provision a Public Subnet:
   Define and create a public subnet within the VPC with a specified CIDR block.
   Ensure that the subnet is appropriately tagged.
4. Create a Route Table:
   Establish a routing table that directs traffic to the Internet Gateway.
   Ensure that the route table is associated with the VPC.
5. Security Group Creation:
   Set up a security group to manage inbound and outbound traffic to the EC2 instance.
   Define the necessary security group rules for the web server.
6. Launch an EC2 Instance:
   Deploy an EC2 instance with a specified Amazon Machine Image (AMI), instance type, and key pair.
   Associate the EC2 instance with the public subnet and security group you've created.
   Utilize Terraform provisioners to automatically install Apache2 on the EC2 instance.
7. Output Variable Configuration:
   Define an output variable to display the public IP address of the web server.
8. Variable Usage:
   Utilize variables in your Terraform configuration to avoid hardcoding values such as AWS region, AMI ID, and other configuration parameters.
9. Access the Web Server:
   Use the public IP address obtained from the output variable to access the web server via a web browser.
   Note: Properly structure your Terraform files, including variables.tf, main.tf, and outputs.tf. Validate and apply your Terraform configuration to create the infrastructure and confirm successful access to the web server.