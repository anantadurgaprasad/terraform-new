resource "aws_vpc" "tf-vpc" {
     cidr_block = "${var.vpc-cidr}"
     instance_tenancy = "default"

  tags = {
    Name = "${var.vpc-name}"
  }
  
}