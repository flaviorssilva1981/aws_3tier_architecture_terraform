## Route Table to public subnet

resource "aws_route_table" "rtb-pub" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "RT-Public"
  }
}

resource "aws_route_table_association" "a" {
#  subnet_id      = aws_subnet.sub-public[count.index].id
  subnet_id      = aws_subnet.sub-public-01.id 
  route_table_id = aws_route_table.rtb-pub.id
#  count = 2
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.sub-public-02.id
  route_table_id = aws_route_table.rtb-pub.id
}

## Route Table to private subnet

resource "aws_route_table" "rtb-pri" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "RT-Private"
  }
}


resource "aws_route_table_association" "c" {
#  subnet_id      = aws_subnet.sub-public[count.index].id
  subnet_id      = aws_subnet.sub-private-01.id 
  route_table_id = aws_route_table.rtb-pri.id
#  count = 2
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.sub-private-02.id
  route_table_id = aws_route_table.rtb-pri.id
}


/*
//Adding NAT Gateway into the default main route table
resource "aws_default_route_table" "rtb-pri" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "rtb-pri"
  }
}
*/

