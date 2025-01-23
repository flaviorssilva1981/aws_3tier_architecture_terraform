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

## AMI

variable "ami-sandbox" {
  default = "ami-05576a079321f21f8"
}

## Instance Type

variable "instance-type" {
  default = "t2.micro"
}

## Key

variable "key-name" {
  default = "lab01"
}

variable "key-source" {
  default = "./lab01.pem"
}

variable "key-destination" {
  default = "/home/ec2-user/lab01.pem"
}

variable "key-type" {
  default = "ssh"
}

## User

variable "user" {
  default = "ec2-user"
}


## TAG

variable "tag" {
  default = "SandBox"
}


# EBS

variable "ebs-hanalog-size" {
  default = 12
}

variable "ebs-type" {
  default = "gp3"
}

# EBS Attachment

variable "ebs-hanalog-device-name" {
  default = "/dev/sdf"
}