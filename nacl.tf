

resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id


  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

/*
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

*/

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

/*  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  egress {  //Ephemeral Port
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
*/
  tags = {
    Name = "main"
  }
}

resource "aws_network_acl_association" "main-01" {
  network_acl_id = aws_network_acl.main.id
#  subnet_id      = aws_subnet.public[count.index].id
  subnet_id      = aws_subnet.sub-public-01.id
#  count = 2
}

resource "aws_network_acl_association" "main-02" {
  network_acl_id = aws_network_acl.main.id
#  subnet_id      = aws_subnet.public[count.index].id
  subnet_id      = aws_subnet.sub-public-02.id
#  count = 2
}

resource "aws_network_acl_association" "main-03" {
  network_acl_id = aws_network_acl.main.id
#  subnet_id      = aws_subnet.public[count.index].id
  subnet_id      = aws_subnet.sub-private-01.id
#  count = 2
}


resource "aws_network_acl_association" "main-04" {
  network_acl_id = aws_network_acl.main.id
#  subnet_id      = aws_subnet.public[count.index].id
  subnet_id      = aws_subnet.sub-private-02.id
#  count = 2
}