# data "aws_iam_policy_document" "codeDeploy-assume-role-policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["codedeploy.amazonaws.com"]
#     }
#   }
# }


# module "cd-role" {
#   source = "./Modules/IAM"
#   role-name = "CODE-DEPLOY-SERVICE-ROLE"
#   policy-file-name = data.aws_iam_policy_document.codeDeploy-assume-role-policy.json
#   policy-arns = "${var.cd-policy-arn}"
# }


# module "codeDeploy" {
#   source = "./Modules/CodeDeploy"
#   application-name = "${var.env}-${var.app-name}-CodeDeploy"
#   deploy-group-name = "${var.env}-${var.app-name}-CodeDeploy-Group"
#   iam-role-arn = module.cd-role.iam-arn
#   asg-list = [module.asg.asg-name]
# }