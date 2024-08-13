output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my_instance2.id
}

output "security_group_id" {
  value = data.aws_security_group.ivan_SG2
}
