resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.subnet-group-name}"
  subnet_ids = "${var.subnet-group-ids}"

 
}



resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      =  "${var.cluster-name}"
  engine                  =  "${var.rds-engine}"
  engine_version          = "${var.rds-version}"
  database_name           =  "${var.rds-db-name}"
  master_username         =  "${var.rds-username}"
  master_password         =   "${var.rds-psd}"
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = "${var.rds-sg}"
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  
  identifier         = "${var.rds-name}"
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "${var.db_instance_type}"
  engine             = aws_rds_cluster.postgresql.engine
  engine_version     = aws_rds_cluster.postgresql.engine_version
}




# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   engine               = "${var.rds-engine}"
#   engine_version       = "${var.engine-version}"
  
#   instance_class       =  "${var.rds-instance-class}"
#   db_subnet_group_name =   aws_db_subnet_group.default.name
#   username            = "${var.rds-username}"
  
#   password             =  "${var.rds-psd}"
  
#   vpc_security_group_ids = "${var.rds-sg}"
#   db_name = "${var.rds-db-name}"
#   skip_final_snapshot  = true
# }







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