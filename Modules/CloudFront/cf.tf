resource "aws_cloudfront_origin_access_control" "oai" {
  name                              = "s3-access"
  description                       = "oai for s3 access"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}






resource "aws_cloudfront_distribution" "cf-distribution" {
    origin {
      domain_name = "${var.alb-dns}"
      origin_id = "web_alb"
      custom_origin_config{
        http_port = 80
        https_port = 443
        origin_protocol_policy="http-only"
        origin_ssl_protocols=["TLSv1.2"] 
      }
    }
    origin {
      domain_name="${var.s3-domain-name}"
      origin_id="${var.env}-${var.app-name}-cloudfront-s3"
      
        origin_access_control_id = aws_cloudfront_origin_access_control.oai.id
      
    }
    enabled = true
    
    restrictions{
        geo_restriction {
      restriction_type = "none"
      
    }
    }
    

    default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "web_alb"

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

    viewer_protocol_policy = "redirect-to-https"
   
  }


  ordered_cache_behavior {
    path_pattern     = "/memberex/default/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.env}-${var.app-name}-cloudfront-s3"

     cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

   
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  


     viewer_certificate {
    cloudfront_default_certificate = true
  }

}