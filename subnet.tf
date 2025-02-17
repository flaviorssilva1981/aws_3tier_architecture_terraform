

resource "aws_subnet" "sub-public-01" {
  vpc_id     = aws_vpc.main.id
#  cidr_block = var.sub-cidr[count.index]
  cidr_block = var.sub-pub-cidr-01
#  availability_zone = var.az[count.index]
  availability_zone = var.az-01
  map_public_ip_on_launch = true
#  count = 2

  tags = {
    Name = "public-sub-01"
  }
}

resource "aws_subnet" "sub-private-01" {
  vpc_id     = aws_vpc.main.id
#  cidr_block = var.sub-cidr[count.index]  
  cidr_block = var.sub-pri-cidr-01
  availability_zone = var.az-01
#  availability_zone = var.az[count.index]
#  count = 2
  tags = {
    Name = "private-sub-01"
  }
}


resource "aws_subnet" "sub-public-02" {
  vpc_id     = aws_vpc.main.id
#  cidr_block = var.sub-cidr[count.index]
  cidr_block = var.sub-pub-cidr-02
#  availability_zone = var.az[count.index]
  availability_zone = var.az-02
  map_public_ip_on_launch = true
#  count = 2

  tags = {
    Name = "public-sub-02"
  }
}

resource "aws_subnet" "sub-private-02" {
  vpc_id     = aws_vpc.main.id
#  cidr_block = var.sub-cidr[count.index]  
  cidr_block = var.sub-pri-cidr-02
  availability_zone = var.az-02
#  availability_zone = var.az[count.index]
#  count = 2
  tags = {
    Name = "private-sub-02"
  }
}




data "aws_subnets" "sid" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }

  tags = {
    Tier = "Public"
  }
}
