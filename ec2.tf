# Author    : Ranjit Kumar Swain
# Web       : www.ranjitswain.com
# YouTube   : https://www.youtube.com/c/ranjitswain
# GitHub    : https://github.com/ranjit4github
########################################################

resource "aws_instance" "web" {
  ami           = "ami-0507f77897697c4ba"
  instance_type = "t2.micro"
  key_name = "lab01"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

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
  ami           = "ami-0507f77897697c4ba"
  instance_type = "t2.micro"
  key_name = "lab01"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}
