resource "aws_instance" "ec2" {
  ami           = "ami-0f36dcfcc94112ea1"
  instance_type = "t3.micro"
  key_name = "${var.key-name}"
  availability_zone = "${var.az}"
  subnet_id = "${var.subnet-id}"
  security_groups = "${var.sg}"
  associate_public_ip_address = "${var.public-ip}"

  tags = {
    Name = "${var.ec2-name}"
  }
}