resource "aws_instance" "ec2" {
  ami           = "ami-0f36dcfcc94112ea1"
  instance_type = "t2.micro"
  key_name = "${var.key-name}"
  availability_zone = "${var.az}"
  subnet_id = "${var.subnet-id}"
  security_groups = "${var.sg}"
  associate_public_ip_address = "${var.public-ip}"
  user_data = <<EOF
#!/bin/bash 
sudo yum update -y
sudo yum install -y httpd 
systemctl start httpd
systemctl enable httpd
echo "Hello world $(hostname -f)" > /var/www/html/index.html
EOF

  tags = {
    Name = "${var.ec2-name}"
  }
}