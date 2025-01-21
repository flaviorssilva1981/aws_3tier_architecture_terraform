

resource "aws_instance" "web" {
  ami           = "ami-05576a079321f21f8"
  instance_type = "t2.micro"
  key_name = "lab01"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

## User Data

  user_data = file("/mnt/c/guga/projetos/aws/infra/aws_3tier_architecture_terraform/user_data.tpl")
   

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
