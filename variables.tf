#### VPC

variable "vpc-cidr" {
default = "10.0.169.0/24"
}

#### Subnets

variable "sub-pub-cidr-01" {
#  type = list
#  default = ["10.0.169.0/28","10.0.169.128/28","10.0.169.16/28","10.0.169.144/28"]
default = "10.0.169.0/28"
}

variable "sub-pub-cidr-02" {
default = "10.0.169.128/28"
}

variable "sub-pri-cidr-01" {
default = "10.0.169.16/28"
}

variable "sub-pri-cidr-02" {
default = "10.0.169.144/28"
}

#### Availability Zones

variable "az-01" {
#  type = list
#  default = ["us-east-1a","us-east-1c"]
  default = "us-east-1a"
}


variable "az-02" {
#  type = list
  default = "us-east-1c"
}

data "aws_availability_zones" "available" {}
# Data block to reference an existing EC2 instance by ID
data "aws_instance" "sandbox01" {
  instance_id = aws_instance.sandbox01.id # Replace with your instance ID
}

## AMI

variable "ami-sandbox" {
  default = "ami-00fd7a6563f4b004f"
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


### EBS

# EBS hanalog

variable "ebs-hanalog-size" {
  default = 12
}

variable "ebs-type" {
  default = "gp3"
}

# EBS Attachment hanalog

variable "ebs-hanalog-device-name" {
  default = "/dev/sdb"
}

# EBS hanadata

variable "ebs-hanadata-size" {
  default = 61
}

/*
variable "ebs-type" {
  default = "gp3"
}
*/

# EBS Attachment hanadata

variable "ebs-hanadata-device-name" {
  default = "/dev/sdc"
}


# EBS hanashared

variable "ebs-hanashared-size" {
  default = 31
}

/*
variable "ebs-type" {
  default = "gp3"
}
*/

# EBS Attachment hanashared

variable "ebs-hanashared-device-name" {
  default = "/dev/sdd"
}


# EBS hanabackup

variable "ebs-hanabackup-size" {
  default = 51
}

/*
variable "ebs-type" {
  default = "gp3"
}
*/

# EBS Attachment hanabackup

variable "ebs-hanabackup-device-name" {
  default = "/dev/sde"
}


# EBS usrsap

variable "ebs-usrsap-size" {
  default = 41
}

/*
variable "ebs-type" {
  default = "gp3"
}
*/

# EBS Attachment usrsap

variable "ebs-usrsap-device-name" {
  default = "/dev/sdf"
}

# EBS swap

variable "ebs-swap-size" {
  default = 16
}

/*
variable "ebs-type" {
  default = "gp3"
}
*/

# EBS Attachment swap

variable "ebs-swap-device-name" {
  default = "/dev/sdg"
}