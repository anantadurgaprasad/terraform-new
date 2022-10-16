output "s3-domain-name" {
  value = aws_s3_bucket.my-aws_s3_bucket.bucket_regional_domain_name
}
output "s3-id" {
  value=aws_s3_bucket.my-aws_s3_bucket.id
}
output "s3-arn" {
  value = aws_s3_bucket.my-aws_s3_bucket.arn
}
output "s3-name" {
  value = aws_s3_bucket.my-aws_s3_bucket.bucket
}