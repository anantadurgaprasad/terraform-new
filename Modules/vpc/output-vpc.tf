output "vpc-id" {
  value=aws_vpc.tf-vpc.id
}

output "private-sg-id" {
  value=aws_security_group.private_sg.id
}

output "public-sg-id" {
  value=aws_security_group.public_sg.id  
}

output "lb-sg-id" {
  value = aws_security_group.lb_sg.id
  
}
output "rds-sg-id" {
  value = aws_security_group.rds_sg.id
  
}
