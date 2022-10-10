

#############------------------------################



# output "fingerprint" {
#   value = data.aws_key_pair.example.fingerprint
# }

# output "name" {
#   value = data.aws_key_pair.example.key_name
# }

# output "id" {
#   value = data.aws_key_pair.example.id
# }








/*

*/



# resource "aws_lb_target_group_attachment" "lb-tg" {
#   target_group_arn = module.load-balancer.tg-arn
#   target_id = module.private-ec2.ec2-id
#   port = 80

  
# }
# resource "aws_lb_target_group_attachment" "lb-tg2" {
#   target_group_arn = module.load-balancer.tg-arn
#   target_id = module.public-ec2.ec2-id
#   port = 80

  
# }






/*

resource "aws_db_subnet_group" "default" {
  name       = "terraform-subnet-group"
  subnet_ids = [module.private_subnet_1.id , module.private_subnet_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_security_group" "aws_db_sg" {
  vpc_id = module.new_vpc.vpc-id

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.private_subnet_2.cidr]
  }
  tags = {
    "name" = "rds-sg"
  }
  
}

module "rds" {
  source = "./Modules/rds"
  rds-engine = "postgres"
  rds-instance-class = "db.t3.micro"
  rds-subnet-group = aws_db_subnet_group.default.name
  
  rds-username = "durga"
  rds-psd = "terraform-durga"
  rds-db-name = "durgadb"
  rds-sg = [aws_security_group.aws_db_sg.id]
  
}
*/