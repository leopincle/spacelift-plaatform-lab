provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "platform" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "platform-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.platform.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "platform-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.platform.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true

  tags = {
    Name = "platform-subnet-b"
  }
}

output "vpc_id" {
  value = aws_vpc.platform.id
}

output "subnet_ids" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}