resource "aws_subnet" "vpc-subnet" {
  vpc_id = "${var.vpc-id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "${var.az}"
  tags = {
    Name = "${var.subnet-name}"
  }
}