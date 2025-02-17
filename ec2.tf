### Create EC2

resource "aws_instance" "sandbox01" {
  ami           = var.ami-sandbox
  instance_type = var.instance-type
  key_name = var.key-name
#  subnet_id = aws_subnet.sub-public[count.index].id
  subnet_id = aws_subnet.sub-public-01.id
  vpc_security_group_ids = [aws_security_group.sg-private.id]
  associate_public_ip_address = true
#  count = 2

## User Data

  user_data = file("/mnt/c/guga/projetos/aws/infra/aws_3tier_architecture_terraform/user_data_02.tpl")

  tags = {
    Name = var.tag
  }

  provisioner "file" {
    source = var.key-source
    destination = var.key-destination
  
    connection {
      type = var.key-type
      host = self.public_ip
      user = var.user
      private_key = "${file("./lab01.pem")}"
    }  
  }
}

# Create an EBS volume hanalog
resource "aws_ebs_volume" "hanalog-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = var.ebs-hanalog-size # Size in GB
  type              = var.ebs-type  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume hanalog to the EC2 instance
resource "aws_volume_attachment" "hanalog-attach" {
  device_name = var.ebs-hanalog-device-name  # You can change this to your preferred device name
  volume_id   = aws_ebs_volume.hanalog-ebs.id
  instance_id = aws_instance.sandbox01.id
}


# Create an EBS volume hanadata
resource "aws_ebs_volume" "hanadata-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = var.ebs-hanadata-size # Size in GB
  type              = var.ebs-type  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume hanadata to the EC2 instance
resource "aws_volume_attachment" "hanadata-attach" {
  device_name = var.ebs-hanadata-device-name  # You can change this to your preferred device name
  volume_id   = aws_ebs_volume.hanadata-ebs.id
  instance_id = aws_instance.sandbox01.id
}

# Create an EBS volume hanashared
resource "aws_ebs_volume" "hanashared-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = var.ebs-hanashared-size # Size in GB
  type              = var.ebs-type  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume hanashared to the EC2 instance
resource "aws_volume_attachment" "hanashared-attach" {
  device_name = var.ebs-hanashared-device-name  # You can change this to your preferred device name
  volume_id   = aws_ebs_volume.hanashared-ebs.id
  instance_id = aws_instance.sandbox01.id
}

# Create an EBS volume hanabackup
resource "aws_ebs_volume" "hanabackup-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = var.ebs-hanabackup-size # Size in GB
  type              = var.ebs-type  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume hanabackup to the EC2 instance
resource "aws_volume_attachment" "hanabackup-attach" {
  device_name = var.ebs-hanabackup-device-name  # You can change this to your preferred device name
  volume_id   = aws_ebs_volume.hanabackup-ebs.id
  instance_id = aws_instance.sandbox01.id
}

# Create an EBS volume usrsap
resource "aws_ebs_volume" "usrsap-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = var.ebs-usrsap-size # Size in GB
  type              = var.ebs-type  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume usrsap to the EC2 instance
resource "aws_volume_attachment" "usrsap-attach" {
  device_name = var.ebs-usrsap-device-name  # You can change this to your preferred device name
  volume_id   = aws_ebs_volume.usrsap-ebs.id
  instance_id = aws_instance.sandbox01.id
}


# Create an EBS volume swap
resource "aws_ebs_volume" "swap-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = var.ebs-swap-size # Size in GB
  type              = var.ebs-type  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume swap to the EC2 instance
resource "aws_volume_attachment" "swap-attach" {
  device_name = var.ebs-swap-device-name  # You can change this to your preferred device name
  volume_id   = aws_ebs_volume.swap-ebs.id
  instance_id = aws_instance.sandbox01.id
}