provider "aws" {
	region = "us-east-1"
}	

locals {
  vpc_name = "${terraform.workspace} - vpc"
  gtw_name = "${terraform.workspace} - gateway"
  sub_name = "${terraform.workspace} - subnet"
  route_name = "${terraform.workspace} - route"
}

resource "aws_vpc" "ivan_VPC" {
  cidr_block = var.cidr_ip_vpc

  tags = {
    Name = local.vpc_name
    Owner = "${terraform.workspace} - ${var.Owner_my}"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.ivan_VPC.id
  cidr_block = var.cidr_ip_sub
  map_public_ip_on_launch = true
  tags = {
    Name = local.sub_name
    Owner = "${terraform.workspace} - ${var.Owner_my}"
  } 
}

resource "aws_internet_gateway" "igw_Ivan" {
  vpc_id = aws_vpc.ivan_VPC.id

  tags = {
    Name = local.gtw_name
    Owner = "${terraform.workspace} - ${var.Owner_my}"
  }
}

resource "aws_route_table" "route_Ivan" {
  vpc_id = aws_vpc.ivan_VPC.id

  route {
    cidr_block =var.cidr_ip_route
    gateway_id = aws_internet_gateway.igw_Ivan.id
  }

  tags = {
    Name = local.route_name
    Owner = "${terraform.workspace} - ${var.Owner_my}"
  }
}


resource "random_password" "password_for_RDS" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}



resource "aws_ssm_parameter" "rds" {
  name  = "ivan_rds"
  type  = "SecureString"
  value = random_password.password_for_RDS.result
  tags = {
    environment = "test"
  }
}

resource "aws_db_instance" "RDS" {
  instance_class    = "db.t3.micro"
  allocated_storage = 10
  engine            = "mysql"
  username          = "ivan11"
  password          = aws_ssm_parameter.rds.value
  skip_final_snapshot = true
  db_name = "mydb_Ivan"
  tags = {
     Name = "Ivan_db"
  }
}