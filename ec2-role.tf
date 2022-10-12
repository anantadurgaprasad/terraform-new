data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

module "ec2-iam-role" {
    source = "./Modules/IAM"
    role-name = "EC2-LT-ROLE"
    policy-file-name = data.aws_iam_policy_document.instance-assume-role-policy.json
    policy-arns = "${var.ec2-policy-arns}"
  
}