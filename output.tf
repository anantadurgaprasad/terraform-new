output "name" {
  value = module.public_subnet
}

output "trial" {
  value=data.aws_iam_policy_document.cf_policy.policy_id
}

# output "psd" {
#   value = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string).password
#   sensitive = true
# }