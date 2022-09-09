output "id" {
    value = aws_subnet.vpc-subnet.id
}
output "cidr" {
  value=aws_subnet.vpc-subnet.cidr_block
}