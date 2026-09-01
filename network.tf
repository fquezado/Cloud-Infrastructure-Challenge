// Main VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MainVPC"
  }
}

// Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.azs[count.index]

  tags = {
    Name = "PublicSubnet-${count.index}"
  }
}

// Private Subnets
resource "aws_subnet" "private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = var.azs[count.index]

  tags = {
    Name = "PrivateSubnet-${count.index}"
  }
}
