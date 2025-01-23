

resource "aws_instance" "web" {
  ami           = var.ami-sandbox
  instance_type = var.instance-type
  key_name = var.key-name
#  subnet_id = aws_subnet.public[count.index].id
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
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

# Create an EBS volume
resource "aws_ebs_volume" "hanalog-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = var.ebs-hanalog-size # Size in GB
  type              = var.ebs-type  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "hanalog-attach" {
  device_name = var.ebs-hanalog-device-name  # You can change this to your preferred device name
  volume_id   = aws_ebs_volume.hanalog-ebs.id
  instance_id = aws_instance.web.id
}




resource "aws_instance" "db" {
  ami           = "ami-05576a079321f21f8"
  instance_type = "t2.micro"
  key_name = "lab01"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}

