provider "aws" {
	region = "us-east-1"
}	


resource "aws_security_group" "ivan_SG2" {
  vpc_id = aws_vpc.ivan_VPC.id
  name        = "ivan_SG2"
  description = "SG for exxampe number 2"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_vpc" "ivan_VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Ivan_vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.ivan_VPC.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_Ivan"
  }
}

resource "aws_internet_gateway" "igw_Ivan" {
  vpc_id = aws_vpc.ivan_VPC.id

  tags = {
    Name = "IGW_Ivan"
  }
}

resource "aws_route_table" "route_Ivan" {
  vpc_id = aws_vpc.ivan_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_Ivan.id
  }

  tags = {
    Name = "route_table_Ivan"
  }
}


resource "aws_instance" "my_instance2" {
	ami = "ami-04a81a99f5ec58529"
	instance_type = "t3.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.ivan_SG2.id]
    tags = {
      Name = "ivan_instance2"
    }
}	

data "aws_security_group" "ivan_SG2" {
  filter {
    name   = "group-name"
    values = ["ivan_SG2"]
  }
}