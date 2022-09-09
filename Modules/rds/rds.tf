resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "${var.rds-engine}"
  # engine_version       = "13.1"
  
  instance_class       =  "${var.rds-instance-class}"
  db_subnet_group_name =      "${var.rds-subnet-group}"
  username            = "${var.rds-username}"
  
  password             =  "${var.rds-psd}"
  # security_group_names = "${var.rds-sg}"
  vpc_security_group_ids = "${var.rds-sg}"
  db_name = "${var.rds-db-name}"
  skip_final_snapshot  = true
}

#--------------------------------------------https://755754929567.signin.aws.amazon.com/console
# resource "aws_db_instance" "education" {
#   identifier             = "education"
#   instance_class         = "db.t3.micro"
#   allocated_storage      = 5
#   engine                 = "postgres"
#   engine_version         = "13.1"
#   username               = "edu"
#   password               = var.db_password
#   db_subnet_group_name   = aws_db_subnet_group.education.name
#   vpc_security_group_ids = [aws_security_group.rds.id]
#   parameter_group_name   = aws_db_parameter_group.education.name
#   publicly_accessible    = true
#   skip_final_snapshot    = true
# }