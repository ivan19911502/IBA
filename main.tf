provider "aws" {
	region = "us-east-1"
}	


resource "aws_security_group" "ivan_SG" {
  name        = "ivan_SG"
  description = "SG for exxampe number 1"

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


resource "aws_instance" "my_instance" {
	ami = "ami-0a0e5d9c7acc336f1"
	instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.ivan_SG.id]
    tags = {
      Name = "ivan_instance"
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


resource "aws_instance" "my_instance2" {
	ami = "ami-0a0e5d9c7acc336f1"
	instance_type = "t3.micro"
    vpc_id = [aws_vpc.ivan_VPC.id]
    subnet_id = [aws_subnet.public.id]
    vpc_security_group_ids = [aws_security_group.ivan_SG.id]
    tags = {
      Name = "ivan_instance"
    }
}	