module "cloudwatch-group" {
  source = "./Modules/CloudWatch"
  cloudwatch-group-name = "${var.env}-${var.app-name}-cloudwatch-group"
  cloudwatch-group-retention-days = "${var.cloudwatch-group-retention}"
}