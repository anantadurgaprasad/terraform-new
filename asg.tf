module "asg" {
  source = "./Modules/ASG"
  tg-arn = module.load-balancer.tg-arn
  lc-id = module.launch-template.lc-id
  desired-capacity = "${var.desired-capacity}"
  max-size = "${var.max-size}"
  min-size = "${var.min-size}"
  asg-subnets = [module.private_subnet[0].id]
  env="${var.env}"
  app-name = "${var.app-name}"
  
}