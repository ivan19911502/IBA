output "ivan_VPC" {
  value = aws_vpc.ivan_VPC.id
}

output "ivan_VPC_ip" {
  value = aws_vpc.ivan_VPC.cidr_block
}

output "password" {
   value = random_password.password_for_RDS.result
   sensitive = true
 }

 output "id" {
   value = aws_db_instance.RDS.id
 }