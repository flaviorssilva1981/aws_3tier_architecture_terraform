

resource "aws_instance" "web" {
  ami           = "ami-05576a079321f21f8"
  instance_type = "t2.micro"
  key_name = "lab01"
#  subnet_id = aws_subnet.public[count.index].id
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
#  count = 2

## User Data

  user_data = file("/mnt/c/guga/projetos/aws/infra/aws_3tier_architecture_terraform/user_data_02.tpl")
   

  tags = {
    Name = "WebServer"
  }

  provisioner "file" {
    source = "./lab01.pem"
    destination = "/home/ec2-user/lab01.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./lab01.pem")}"
    }  
  }
}

# Create an EBS volume
resource "aws_ebs_volume" "hanalog-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # First AZ
  size              = 12  # Size in GB
  type              = "gp3"  # General Purpose SSD (You can change this to your preferred type)
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "hanalog-attach" {
  device_name = "/dev/sdf"  # You can change this to your preferred device name
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

