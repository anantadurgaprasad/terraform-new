module "load-balancer" {
  source = "./Modules/LB"
  lb-name = "${var.env}-${var.app-name}-alb"
  lb-sg = [module.new_vpc.lb-sg-id]
  lb-subnets = [ for subnet in module.public_subnet: subnet.id]
  tg-name = "${var.env}-${var.app-name}-tg"
  vpc-id = module.new_vpc.vpc-id
  
}
