resource "aws_nat_gateway" "example" {
  allocation_id = "${var.eip-id}"
  subnet_id     ="${var.subnet_id}"

  tags = {
    Name = "${var.nat-name}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  
}