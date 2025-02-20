#### VPC

variable "vpc-cidr" {
default = "10.0.169.0/24"
}

variable "vpc-name" {
default = "Sandbox-VPC"
}

#### Public Subnets

# Public Subnet 01

variable "sub-pub-cidr-01" {
#  type = list
#  default = ["10.0.169.0/28","10.0.169.128/28","10.0.169.16/28","10.0.169.144/28"]
default = "10.0.169.0/28"
}

variable "public-sub-name-01" {
default = "Public-Subnet-01"
}

# Public Subnet 02

variable "sub-pub-cidr-02" {
default = "10.0.169.128/28"
}

variable "public-sub-name-02" {
default = "Public-Subnet-02"
}

#### Private Subnets

# Private Subnet 01

variable "sub-pri-cidr-01" {
default = "10.0.169.16/28"
}

variable "private-sub-name-01" {
default = "Private-Subnet-01"
}

# Private Subnet 02

variable "sub-pri-cidr-02" {
default = "10.0.169.144/28"
}

variable "private-sub-name-02" {
default = "Private-Subnet-02"
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

/*
# Data block to reference an existing EC2 instance by ID
data "aws_instance" "sandbox01" {
  instance_id = aws_instance.sandbox01.id # Replace with your instance ID
}
*/
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
  default = "sandbox-key"
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

## EC2 Instance Name

variable "instance-name" {
  default = "SandBox"
}


#### Create a volumes EBS

# EBS boot

variable "ebs-boot-size" {
  default = 150
}

variable "boot-name" {
  default = "/"
}


# EBS hanalog

variable "ebs-hanalog-size" {
  default = 12
}

variable "ebs-type" {
  default = "gp3"
}

variable "ebs-hanalog-name" {
  default = "/hana/log"
}


# EBS Attachment hanalog

variable "ebs-hanalog-device-name" {
  default = "/dev/sdb"
}

# EBS hanadata

variable "ebs-hanadata-size" {
  default = 61
}

variable "ebs-hanadata-name" {
  default = "/hana/data"
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

variable "ebs-hanashared-name" {
  default = "/hana/shared"
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

variable "ebs-hanabackup-name" {
  default = "/hana/backup"
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

variable "ebs-usrsap-name" {
  default = "/usr/sap"
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

variable "ebs-swap-name" {
  default = "/swap"
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

#### VPC Peering - MIGNOW

variable "mig-peering-name" {
  default = "COOPERCITRUS <==> MIGNOW"
}

variable "mig-account-id" {
  default = "542645490141"
}

variable "mig-vpc-id" {
  default = "vpc-0160249f18e6c2891"
}

#### VPC Peering - INFRACLOUD

variable "infra-peering-name" {
  default = "COOPERCITRUS <==> INFRACLOUD"
}

variable "infra-account-id" {
  default = "081615871559"
}

variable "infra-vpc-id" {
  default = "vpc-02bc2026b34bf4e8b"
}

#### Elastic IP for NAT Gateway

variable "eip-nat-gw" {
  default = "NAT Gateway Elastic IP"
}


#### Bucket AWS S3

variable "bucket-name" {
  default = "coopercitrus-bucket"
}

variable "bucket-folder" {
  default = "backup-hana/"
}