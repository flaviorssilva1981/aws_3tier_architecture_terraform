variable "cidr" {
#  type = list
#  default = ["10.0.1.0/24","10.0.2.0/24"]
default = "10.0.1.0/24"
}

variable "az" {
#  type = list
#  default = ["us-east-1a","us-east-1c"]
  default = "us-east-1a"
}

data "aws_availability_zones" "available" {}
# Data block to reference an existing EC2 instance by ID
data "aws_instance" "web" {
  instance_id = aws_instance.web.id # Replace with your instance ID
}