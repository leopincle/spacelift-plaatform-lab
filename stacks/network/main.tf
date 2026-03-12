provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "platform" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "platform-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.platform.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "platform-subnet"
  }
}

output "vpc_id" {
  value = aws_vpc.platform.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}