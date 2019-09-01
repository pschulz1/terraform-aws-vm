output "id" {
  value = aws_instance.main.id
}

output "name" {
  value = aws_instance.main.tags.Name
}

output "availability_zone" {
  value = aws_instance.main.availability_zone
}

output "subnet_id" {
  value = aws_instance.main.subnet_id
}

output "vpc_security_group_ids" {
  value = aws_instance.main.vpc_security_group_ids
}

output "private_ip" {
  value = aws_instance.main.private_ip
}

output "public_ip" {
  value = aws_instance.main.public_ip
}

output "private_dns" {
  value = aws_instance.main.private_dns
}

output "public_dns" {
  value = aws_instance.main.public_dns
}
