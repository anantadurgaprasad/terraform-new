data "aws_key_pair" "example" {
  key_name           = "${var.ec2-key-name}"
  //include_public_key = false

 
}



module "public-ec2" {
  source = "./Modules/ec2"
  ec2-name = "${var.env}-${var.app-name}-jump-server-apne2"
  key-name = "${var.ec2-key-name}"
  # az="${element(var.az,0)}"
  subnet-id = module.public_subnet[0].id
  sg = [module.new_vpc.public-sg-id]
  public-ip = true
  ami-id = "${var.ami-id}"
  instance-type = "${var.instance-type}"
}


/*
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

data "aws_key_pair" "example" {
  key_name           = "durga-private"
  include_public_key = false

  # filter {
  #   name   = "tag:Name"
  #   values = ["durga-private"]
  # }
}
*/
