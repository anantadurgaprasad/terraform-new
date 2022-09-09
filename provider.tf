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
    bucket = "terraform-state-file-bucket-durga"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "${var.vpc-region}"
}
