# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }
terraform {
  backend "s3" {
    bucket = "prod-memberportal-team1-env"
    key    = "statefile/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "${var.vpc-region}"
}
