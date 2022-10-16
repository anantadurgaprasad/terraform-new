# data "aws_iam_policy_document" "cf_policy" {
#   statement {
#     actions   = ["s3:GetObject"]
   
#     resources = [ "${module.s3-bucket[0].s3-arn}/*" ]

#  principals {
#       identifiers = ["cloudfront.amazonaws.com"]
#       type        = "Service"
#     }
#     condition {
#       test = "StringEquals"
#       variable = "AWS:SourceArn"
#       values = ["${module.cloud-front.cf-arn}"]
#     }
    
#   }
# }


module "s3-bucket" {
    source = "./Modules/s3"
  count =1
  bucket-name="${var.env}-${var.app-name}-${element(var.buckets,count.index)}"
}

# resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
#   bucket = module.s3-bucket[0].s3-id
#   policy = data.aws_iam_policy_document.cf_policy.json
# }