variable "env" {
  //default = "prod"
  
}
variable "app-name" {
  //default = "memberportal-team1"
  
}
variable "vpc-cidr" {
    //default="10.0.0.0/16"
  
}
# variable "vpc" {
  
# }
variable "vpc-region" {
    //default = "ap-northeast-2"
  
}
variable "az" {
  //default = ["ap-northeast-2a","ap-northeast-2b","ap-northeast-2c"]
}

variable "public_subnets_cidr" {
  # count = 4
  # default = cidrsubnet("10.0.0.0/16",8,count+1)
  //default = ["10.0.1.0/24" , "10.0.2.0/24" , "10.0.3.0/24" , "10.0.4.0/24"]
  
}
variable "private_subnets_cidr" {
  
}
variable "buckets" {
  //default = ["cloudfront" , "env"]
}

variable "db-name" {
  //default = "teamadb"
}
variable "rds-engine" {
  //default = "aurora-postgresql"
}
variable "rds-engine-version" {
  //default = "12.8"
}
variable "ec2-policy-arns" {
  //default = ["arn:aws:iam::aws:policy/AmazonS3FullAccess","arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
}

variable "cd-policy-arn" {
  //default = ["arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"]
}
variable "ami-id" {
  
}
variable "instance-type" {
  
}
variable "desired-capacity" {
  
}
variable "min-size" {
  
}
variable "max-size" {
  
}
variable "db-instance-type" {
  
}
variable "ebs-volume-size" {
  
}
variable "ebs-volume-type" {
  
}
variable "ebs-volume-delete-on-termination" {
  
}
variable "ec2-key-name" {
  
}