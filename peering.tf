#### Create VPC Peering to MIGNOW

resource "aws_vpc_peering_connection" "peer_connection-mig" {
  provider = aws.account_1

  peer_owner_id = var.mig-account-id # Account ID of the second account
  peer_vpc_id   = var.mig-vpc-id  # The VPC ID in the peer account

  vpc_id = aws_vpc.main.id  # The VPC ID in the requester account

  auto_accept = false  # Set to false to manually accept the peering request from the other account

  tags = {
    Name = var.mig-peering-name
  }

}

#### Create VPC Peering to INFRACLOUD

resource "aws_vpc_peering_connection" "peer_connection-infra" {
  provider = aws.account_1

  peer_owner_id = var.infra-account-id # Account ID of the second account
  peer_vpc_id   = var.infra-vpc-id  # The VPC ID in the peer account

  vpc_id = aws_vpc.main.id  # The VPC ID in the requester account

  auto_accept = false  # Set to false to manually accept the peering request from the other account

  tags = {
    Name = var.infra-peering-name
  }

}


/*
resource "aws_vpc_peering_connection_accepter" "peer_connection_accepter" {
  provider = aws.account_1
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_connection.id
  auto_accept = true  # Automatically accept the peering request
}
*/