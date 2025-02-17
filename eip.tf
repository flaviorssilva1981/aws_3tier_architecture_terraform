#### Create an Elastic IP for NAT Gateway

resource "aws_eip" "myeip" {
  //instance = aws_instance.sandbox01.id
  vpc      = true
}
