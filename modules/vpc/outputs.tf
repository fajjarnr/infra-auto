output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.main.id
}

output "vpc_endpoint_s3_id" {
  description = "The ID of the S3 VPC endpoint."
  value       = aws_vpc_endpoint.s3.id
}
