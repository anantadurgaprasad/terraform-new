
resource "aws_iam_role" "role" {
  name = "${var.role-name}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = "${var.policy-file-name}"
  managed_policy_arns = "${var.policy-arns}"
}