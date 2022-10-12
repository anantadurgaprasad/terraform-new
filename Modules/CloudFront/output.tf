output "oai-id" {
  value=aws_cloudfront_origin_access_control.oai.id
}
output "cf-arn" {
  value = aws_cloudfront_distribution.cf-distribution.arn
}