resource "aws_cloudfront_distribution" "s3_cf_s3_page_distribution" {
  enabled         = true
  is_ipv6_enabled = true
  comment         = var.page_domain

  origin {
    domain_name = aws_s3_bucket.public_bucket.website_endpoint
    origin_id   = "s3-${var.page_domain}"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_root_object = "index.html"

  aliases = [var.page_domain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-${var.page_domain}"

    compress = true

    min_ttl     = 0
    max_ttl     = 31536000
    default_ttl = 86400

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.page_domain_wildcard_acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  tags = {
    Name   = var.page_domain
    Domain = var.page_domain
    Group  = var.page_domain
  }
}
