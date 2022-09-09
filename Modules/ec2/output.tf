output "ec2-id" {
    value = aws_instance.ec2.id
  
}

output "ec2-ip" {
    value = aws_instance.ec2.private_ip
  
}
