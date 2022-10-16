output "name" {
  value = module.public_subnet
}



# output "psd" {
#   value = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string).password
#   sensitive = true
# }