#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello World $(hostname -f) " > /var/www/html/index.html