# # data "aws_secretsmanager_secret_version" "creds" {
# #   # Fill in the name you gave to your secret
# #   secret_id = "prod/prod-memberportal-team1-secret"
# # }



# module "rds" {
#     source = "./Modules/rds"
#     cluster-name = "${var.env}-${var.app-name}-rds-cluster"
#     rds-engine = "${var.rds-engine}"
#     rds-version = "${var.rds-engine-version}"
#     rds-db-name = "${var.db-name}"
#     //rds-username = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string).username
#     rds-username = "mbportalpg"
#     rds-psd = "sRh3v7L00"
#     //rds-psd = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string).password
#     rds-sg = [module.new_vpc.rds-sg-id]
#     subnet-group-name = "${var.env}-${var.app-name}-rds-subnet-group"
#     subnet-group-ids = [for a in module.private_subnet: a.id]
#     rds-name = "${var.env}-${var.app-name}-rds-instance"
#   db_instance_type = "${var.db-instance-type}"
# }