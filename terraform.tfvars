vpc-region = "ap-northeast-1"
vpc-cidr = "15.0.0.0/16"
az = ["ap-northeast-1a","ap-northeast-1c"]
public_subnets_cidr = ["15.0.1.0/24","15.0.2.0/24"]
private_subnets_cidr = ["15.0.3.0/24", "15.0.4.0/24"]
env = "prod"
app-name = "memberportal-team1"

###-----rds-----####
db-name = "teamadb"
rds-engine = "aurora-postgresql"
rds-engine-version = "12.8"
db-instance-type = "db.t4g.medium"

##-----EC2&ASG---###
ami-id = "ami-078296f82eb463377"
instance-type = "t3.medium"
desired-capacity = "1"
min-size = "1"
max-size = "1"
ebs-volume-size                 = "100"
ebs-volume-type                 = "gp2"
ebs-volume-delete-on-termination = "true"
##ec2-key-name = "prod-memberportal-team1-key-pair"
ec2-key-name = "terraform-tokyo-key-pair"
##----bucket name---##
buckets = ["cloudfront-s3"]

##----arn policies----##
ec2-policy-arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess","arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
cd-policy-arn = ["arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"]

#-----cloudwatch-group--##
cloudwatch-group-retention = 0