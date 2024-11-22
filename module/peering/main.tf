# data "aws_vpc" "default_vpc_id" {
#   id = "vpc-0bd3294f3e6fca7b2"
# }
# resource "aws_vpc_peering_connection" "peer_connection" {
# peer_vpc_id = data.aws_vpc.default_vpc_id
# vpc_id= var.vpc_id
# peer_region = "ap-south-1"

# auto_accept   = true

#   tags = {
#     Name = "VPC Peering between default and main vpc"
#   }
# }

# resource "aws_vpc" "default" {
#     cidr_block="172.31.0.0/16"
#     provider = ap-south-1
  
# }
# resource "aws_vpc" "main_vpc_cidr"{
#     cidr_block =  "10.0.0.0/16"
#     provider = ap-south-1
# }

# Specify the AWS provider and region
provider "aws" {
  region = "ap-south-1"  # Specify the region
}

# Fetch the default VPC from your AWS account
data "aws_vpc" "default_vpc" {
  default = true  # Automatically retrieves the default VPC
}

# Create a new VPC
# resource "aws_vpc" "main_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "Main VPC"
#   }
# }

# Create a VPC Peering Connection between the default VPC and the new VPC
resource "aws_vpc_peering_connection" "peer_connection" {
  vpc_id     = var.vpc_id             # New VPC created via Terraform
  peer_vpc_id = data.aws_vpc.default_vpc.id      # Default VPC fetched via data source
#   peer_region = "ap-south-1"                     # Region for both VPCs

  auto_accept = true  # Automatically accept the peering request

  tags = {
    Name = "VPC Peering between default and main VPC"
  }
}

# Optional: Add routing to the default VPC
resource "aws_route" "default_vpc_route" {
  route_table_id         = data.aws_vpc.default_vpc.main_route_table_id
  destination_cidr_block = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_connection.id
}

# # Optional: Add routing to the new VPC
resource "aws_route" "main_vpc_route" {
  route_table_id         = var.main_route_table_id[0]
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_connection.id
}



