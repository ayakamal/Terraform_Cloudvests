# Define Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_1_cidr
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet1"
  }
}

# Define Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public_subnet_2_cidr
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public_subnet2"
  }
}

# Define Private Subnet 1
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_1_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet1"
  }
}

# Define Private Subnet 2
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private_subnet_2_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet2"
  }
}