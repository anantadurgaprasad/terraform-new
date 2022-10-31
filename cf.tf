module "cloud-front" {
  source= "./Modules/CloudFront"
alb-dns = module.load-balancer.lb
env = "${var.env}"
app-name = "${var.app-name}"
s3-domain-name = module.s3-bucket[0].s3-domain-name
}


