## Route Table to public subnet

resource "aws_route_table" "rtb-pub" {
  vpc_id = aws_vpc.main.id
/*
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
*/
  tags = {
    Name = "RT-Public"
  }
}

## Route Table to private subnet

resource "aws_route_table" "rtb-pri" {
  vpc_id = aws_vpc.main.id
/*
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }
*/
  tags = {
    Name = "RT-Private"
  }
}

### Route Table Association - Public Subnet

resource "aws_route_table_association" "public-01" {
#  subnet_id      = aws_subnet.sub-public[count.index].id
  subnet_id      = aws_subnet.sub-public-01.id 
  route_table_id = aws_route_table.rtb-pub.id
#  count = 2
}

resource "aws_route_table_association" "public-02" {
  subnet_id      = aws_subnet.sub-public-02.id
  route_table_id = aws_route_table.rtb-pub.id
}


### Route Table Association - Public Private

resource "aws_route_table_association" "private-01" {
#  subnet_id      = aws_subnet.sub-public[count.index].id
  subnet_id      = aws_subnet.sub-private-01.id 
  route_table_id = aws_route_table.rtb-pri.id
#  count = 2
}

resource "aws_route_table_association" "private-02" {
  subnet_id      = aws_subnet.sub-private-02.id
  route_table_id = aws_route_table.rtb-pri.id
}

# Create a default route (0.0.0.0/0) pointing to the Internet Gateway
resource "aws_route" "default_route_intgw" {
  route_table_id         = aws_route_table.rtb-pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# Create a default route (0.0.0.0/0) pointing to the NAT Gateway
resource "aws_route" "default_route_natgw" {
  route_table_id         = aws_route_table.rtb-pri.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw.id
}


# Route to MIGNOW VPC Peering
resource "aws_route" "route_to_peer-mig" {
  route_table_id            = aws_route_table.rtb-pri.id  # The ID of the route table you want to update
  destination_cidr_block    = "10.200.100.0/24"  # The CIDR block you want to route to via the peering connection
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_connection-mig.id  # Reference the peering connection ID
}

# Route to INFRACLOUD VPC Peering
resource "aws_route" "route_to_peer-infra" {
  route_table_id            = aws_route_table.rtb-pri.id  # The ID of the route table you want to update
  destination_cidr_block    = "10.240.32.0/20"  # The CIDR block you want to route to via the peering connection
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_connection-infra.id  # Reference the peering connection ID
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

