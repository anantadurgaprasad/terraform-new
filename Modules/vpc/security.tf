
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.tf-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${var.env}-${var.app-name}-public-sg-apne2"
  }
  
}




resource "aws_security_group" "private_sg" {
    vpc_id = aws_vpc.tf-vpc.id
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    "Name" = "${var.env}-${var.app-name}-private-sg-apne2"
  }
  
}
resource "aws_security_group" "lb_sg" {
    vpc_id = aws_vpc.tf-vpc.id
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    "Name" = "${var.env}-${var.app-name}-alb-sg-apne2"
  }
  
}
resource "aws_security_group" "rds_sg" {
    vpc_id = aws_vpc.tf-vpc.id
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    "Name" = "${var.env}-${var.app-name}-rds-sg-apne2"
  }
  
}

resource "aws_security_group_rule" "private_sg_rule_1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  
  source_security_group_id = aws_security_group.public_sg.id
  security_group_id = aws_security_group.private_sg.id

}

resource "aws_security_group_rule" "private_sg_rule_2" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = aws_security_group.rds_sg.id
  security_group_id = aws_security_group.private_sg.id
}
resource "aws_security_group_rule" "private_sg_rule_3" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  source_security_group_id = aws_security_group.lb_sg.id
  security_group_id = aws_security_group.private_sg.id
}

resource "aws_security_group_rule" "rds_sg_rule_1" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = aws_security_group.private_sg.id
  security_group_id = aws_security_group.rds_sg.id
  
}
resource "aws_security_group_rule" "rds_sg_rule_2" {
  type = "ingress"
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  source_security_group_id = aws_security_group.public_sg.id
  security_group_id = aws_security_group.rds_sg.id
}

/*




resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.tf-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
    
  }
  ingress {
    from_port=5432
    to_port=5432
    protocol="tcp"
    security_groups=[aws_security_group.rds_sg.id]
  }
  tags = {
    name = "private-sg"
  }
  
}


resource "aws_security_group" "rds_sg" {
  egress {
  from_port=0
  to_port=0
  protocol="tcp"
  cidr_block = ["0.0.0.0/0"]
  
    }
  ingress  {
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  security_groups = [aws_security_group.public_sg.id , aws_security_group.private_sg.id]

       }

  tags = {
  name = "rds-sg"
      }
  
}


resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.tf-vpc.id

    egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "lb-sg"
  }
  
}


*/