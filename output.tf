output "name" {
  value = module.public_subnet
}

output "trial" {
  value=data.aws_iam_policy_document.cf_policy.policy_id
}
