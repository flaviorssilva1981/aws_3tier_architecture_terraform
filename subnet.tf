

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
#  cidr_block = var.cidr[count.index]
  cidr_block = var.cidr
#  availability_zone = var.az[count.index]
  availability_zone = var.az
#  count = 2

  tags = {
    Name = "public-sub"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-sub3"
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
