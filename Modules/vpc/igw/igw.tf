resource "aws_internet_gateway" "tf-gw" {
  vpc_id = "${var.vpc-id}"

  tags = {
    Name = "${var.igw-name}"
  }
}