#!/bin/bash
# Update the instance
sudo yum update -y
# Install Apache HTTP server
sudo yum install -y httpd
# Start the Apache service
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y jq 
# Create a simple index.html file
echo "Hello from Apache on EC2! from $(hostname -f)" > /var/www/html/index.html
