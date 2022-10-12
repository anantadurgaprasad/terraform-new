
module "new_vpc" {
    source = "./Modules/vpc"
    vpc-cidr = "${var.vpc-cidr}"
    vpc-name = "${var.env}-${var.app-name}-vpc-apne2"
    env = "${var.env}"
    app-name = "${var.app-name}"
    
}


#-----------------------subnets--------------
/*
module "public_subnet_1" {
    source = "./Modules/subnet"
    vpc-id = "${module.new_vpc.vpc-id}"
  public_subnet_cidr="${var.public_subnet}"
  az="${element(var.az,0)}"
  subnet-name="${var.subnet-name-pub-1}"

}

module "public_subnet_2" {
  source = "./Modules/subnet"
  vpc-id = "${module.new_vpc.vpc-id}"
  public_subnet_cidr = "${var.public_subnet_2}"
    az="${element(var.az,1)}"
  
}

module "private_subnet_1" {
    source = "./Modules/subnet"
    vpc-id = "${module.new_vpc.vpc-id}"
  public_subnet_cidr="${var.private_subnet_1}"
  az="${element(var.az,0)}"
  subnet-name="${var.subnet-name-pri-1}"
  
}

module "private_subnet_2" {
    source = "./Modules/subnet"
    vpc-id = "${module.new_vpc.vpc-id}"
  public_subnet_cidr="${var.private_subnet_2}"
  az="${element(var.az,1)}"
  subnet-name="${var.subnet-name-pri-2}"
  
}
*/

module "public_subnet" {
  count = 2
  source = "./Modules/subnet"
  vpc-id = "${module.new_vpc.vpc-id}"
  subnet_cidr = element(var.public_subnets_cidr,count.index)
  az = element(var.az,count.index)
  subnet-name = "${var.env}-${var.app-name}-public-subnet-${count.index+1}-apne2"
  
}
module "private_subnet" {
  count = 2
  source = "./Modules/subnet"
  vpc-id = "${module.new_vpc.vpc-id}"
  subnet_cidr = element(var.private_subnets_cidr,(count.index))
  az = element(var.az,count.index)
  subnet-name = "${var.env}-${var.app-name}-private-subnet-${count.index+1}-apne2"
  
}



#-----------END-OF-SUBNETS-----------------


#--------------------NAT-IGW-EIP--------------

module "nat" {
    source = "./Modules/vpc/nat"
    eip-id = aws_eip.eip_nat.id
    subnet_id = "${module.public_subnet[0].id}"
    nat-name = "${var.env}-${var.app-name}-nat-apne2"
    vpc_id = "${module.new_vpc.vpc-id}"
    depends_on = [module.igw]
  
}

module "igw" {
    source = "./Modules/vpc/igw"
    vpc-id = "${module.new_vpc.vpc-id}"
    igw-name = "${var.env}-${var.app-name}-igw-apne2"
  
}

resource "aws_eip" "eip_nat" {
  vpc = true
}
#--------------------END-OF-NAT-IGW-EIP--------------



#####-----Route Tables and associations ----######


resource "aws_route_table" "public_route_table" {
  vpc_id = "${module.new_vpc.vpc-id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${module.igw.igw-id}"
  }

  tags ={
    Name = "${var.env}-${var.app-name}-public-rt-apne2"
  }
}




resource "aws_route_table_association" "public_rt_association" {
  count = length(module.public_subnet)
  
  subnet_id = "${module.public_subnet[count.index].id}" //Why can't we use for_each here??
  route_table_id = "${aws_route_table.public_route_table.id}"
}


resource "aws_route_table" "private_route_table" {
  vpc_id = "${module.new_vpc.vpc-id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${module.nat.nat-id}"
  }

  tags ={
    Name = "${var.env}-${var.app-name}-private-rt-apne2"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count = length(module.private_subnet)
  subnet_id      = "${module.private_subnet[count.index].id}"

  route_table_id = "${aws_route_table.private_route_table.id}"
}


