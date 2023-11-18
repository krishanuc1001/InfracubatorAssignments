## Assignment-2

### Enhancing Infrastructure with Auto Scaling and DNS

Objective:
In this assignment, you will build upon your existing Terraform infrastructure (Assignment-1) by enabling auto-scaling for the instances based on application load and CPU utilization. 
You will also create a DNS record using Route 53 to provide a domain name for your web server. 
Finally, you will test the DNS record by accessing the web application using the configured domain name.

Instructions:
1. Enabling Auto Scaling for Instances:
   Configure the Auto Scaling Group (ASG) to automatically adjust the number of instances based on the application load and CPU utilization.
   Set up the ASG with a minimum of 2 and a maximum of 3 instances.
   Define a Launch Configuration for the ASG with the same Apache2 installation configuration as in the previous assignment.
   Implement CloudWatch alarms and metrics to monitor CPU utilization. Configure the scale-in and scale-out operations for the ASG based on these metrics.

2. Creating a DNS Name (Route53):
   If you haven't created a DNS record previously, extend your Terraform configuration to create a Route 53 DNS record for your web server
   Ensure that you have a Route 53 hosted zone set up before creating the DNS record.

3. Testing the DNS Record:
   After implementing auto scaling and creating the DNS record, validate your Terraform configuration by applying the changes.
   Test the DNS record by accessing the web application using the domain name you've configured.