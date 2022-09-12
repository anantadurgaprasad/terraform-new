
module "new_vpc" {
    source = "./Modules/vpc"
    vpc-cidr = "${var.vpc-cidr}"
    vpc-name = "Terraform-vpc"
    
}

module "public_subnet_1" {
    source = "./Modules/subnet"
    vpc-id = "${module.new_vpc.vpc-id}"
  public_subnet_cidr="${var.public_subnet}"
  az="${element(var.az,0)}"
  subnet-name="terraform-subnet-1"

}

module "private_subnet_1" {
    source = "./Modules/subnet"
    vpc-id = "${module.new_vpc.vpc-id}"
  public_subnet_cidr="${var.private_subnet_1}"
  az="${element(var.az,0)}"
  subnet-name="terraform-private-subnet-1"
  
}

module "private_subnet_2" {
    source = "./Modules/subnet"
    vpc-id = "${module.new_vpc.vpc-id}"
  public_subnet_cidr="${var.private_subnet_2}"
  az="${element(var.az,1)}"
  subnet-name="terraform-private-subnet-2"
  
}

module "igw" {
    source = "./Modules/vpc/igw"
    vpc-id = "${module.new_vpc.vpc-id}"
    igw-name = "terrform-igw"
  
}

resource "aws_eip" "eip_nat" {
  vpc = true
}

#####-----Route Tables and associations ----######


resource "aws_route_table" "public_route_table" {
  vpc_id = "${module.new_vpc.vpc-id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${module.igw.igw-id}"
  }

  tags ={
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = "${module.public_subnet_1.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}


resource "aws_route_table" "private_route_table" {
  vpc_id = "${module.new_vpc.vpc-id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${module.nat.nat-id}"
  }

  tags ={
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = "${module.private_subnet_2.id}"
  route_table_id = "${aws_route_table.private_route_table.id}"
}


#############------------------------################

data "aws_key_pair" "example" {
  key_name           = "durga-private"
  include_public_key = false

  # filter {
  #   name   = "tag:Name"
  #   values = ["durga-private"]
  # }
}

# output "fingerprint" {
#   value = data.aws_key_pair.example.fingerprint
# }

# output "name" {
#   value = data.aws_key_pair.example.key_name
# }

# output "id" {
#   value = data.aws_key_pair.example.id
# }






module "nat" {
    source = "./Modules/vpc/nat"
    eip-id = aws_eip.eip_nat.id
    subnet_id = "${module.public_subnet_1.id}"
    nat-name = "terraform-nat-gate"
    vpc_id = "${module.new_vpc.vpc-id}"
    depends_on = [module.igw]
  
}



module "private-ec2" {
  source = "./Modules/ec2"
  ec2-name = "terraform-private-ec2"
  key-name = data.aws_key_pair.example.key_name
  az="${element(var.az,1)}"
  subnet-id = module.private_subnet_2.id
  sg=[module.new_vpc.private-sg-id]
  public-ip = false

}

module "public-ec2" {
  source = "./Modules/ec2"
  ec2-name = "terraform-public-ec2"
  key-name = data.aws_key_pair.example.key_name
  az="${element(var.az,0)}"
  subnet-id = module.public_subnet_1.id
  sg = [module.new_vpc.public-sg-id]
  public-ip = true
}

# resource "aws_network_interface" "private-ec2-network_interface" {
#   subnet_id       = module.private_subnet_2.id
  
#   security_groups = [module.new_vpc.private-sg-id]

#   attachment {
#     instance     = module.private-ec2.ec2-id
#     device_index = 0
#   }
# }

# resource "aws_network_interface" "public-ec2-network_interface" {
#   subnet_id = module.public_subnet_1.id

#   security_groups = [module.new_vpc.public-sg-id]

#   attachment {
#     instance= module.public-ec2.ec2-id
#     device_index=1
#   }


  
# }

module "load-balancer" {
  source = "./Modules/LB"
  lb-name = "main-lb"
  lb-sg = [module.new_vpc.lb-sg-id]
  lb-subnets = [ module.public_subnet_1.id, module.private_subnet_2.id]
  tg-name = "lb-tg"
  vpc-id = module.new_vpc.vpc-id
  
}

resource "aws_lb_target_group_attachment" "lb-tg" {
  target_group_arn = module.load-balancer.tg-arn
  target_id = module.private-ec2.ec2-id
  port = 80

  
}
resource "aws_lb_target_group_attachment" "lb-tg2" {
  target_group_arn = module.load-balancer.tg-arn
  target_id = module.public-ec2.ec2-id
  port = 80

  
}



resource "aws_db_subnet_group" "default" {
  name       = "terraform-subnet-group"
  subnet_ids = [module.private_subnet_1.id , module.private_subnet_2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

# resource "aws_db_security_group" "rds-security-group" {
#   name = "rds_sg"
#   ingress {
#     cidr = module.private-ec2.ec2-ip
#   }
  
# }
resource "aws_security_group" "aws_db_sg" {
  vpc_id = module.new_vpc.vpc-id

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.private_subnet_2.cidr]
  }
  tags = {
    "name" = "rds-sg"
  }
  
}

module "rds" {
  source = "./Modules/rds"
  rds-engine = "postgres"
  rds-instance-class = "db.t3.micro"
  rds-subnet-group = aws_db_subnet_group.default.name
  
  rds-username = "durga"
  rds-psd = "terraform-durga"
  rds-db-name = "durgadb"
  rds-sg = [aws_security_group.aws_db_sg.id]
  
}
